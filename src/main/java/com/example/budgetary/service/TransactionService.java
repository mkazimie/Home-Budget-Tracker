package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.SortedSet;


@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;
    private final CategoryService categoryService;
    private final BudgetService budgetService;

    public TransactionService(TransactionRepository transactionRepository, CategoryService categoryService, BudgetService budgetService) {
        this.transactionRepository = transactionRepository;
        this.categoryService = categoryService;
        this.budgetService = budgetService;
    }


    public SortedSet<Transaction> makeTransactionOnCategory(TransactionDto transactionDto, Category transactionCategory,
                                                            User user) {
        Transaction transaction = setNewTransaction(transactionDto, user);
        transaction.setDate(transactionDto.getDate());
        transaction.setCategory(transactionCategory);
        transaction.setBudget(transactionCategory.getBudget());

        BigDecimal transactionSum = transaction.getSum();
        BigDecimal moneyLeft = transactionCategory.getMoneyLeft();
        Budget budget = transactionCategory.getBudget();
        if (transaction.getType().equals("Withdrawal")) {
            transactionCategory.setMoneyLeft(moneyLeft.subtract(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().subtract(transactionSum));
        } else {
            transactionCategory.setMoneyLeft(moneyLeft.add(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().add(transactionSum));
            transactionCategory.setCategoryBudget(transactionCategory.getCategoryBudget().add(transactionSum));
        }
        transaction.setCurrentBalance(budget.getMoneyLeft());
        saveTransaction(transaction);
        addTransactionToBudget(transaction, budget);
        addTransactionToCategory(transaction, transactionCategory);
        return transactionCategory.getTransactions();
    }

    public void makeTransactionOnBudget(TransactionDto transactionDto, User user, Budget budget) {
        SortedSet<Category> budgetCategories = budget.getCategories();
        Transaction transaction = setNewTransaction(transactionDto, user);
        transaction.setBudget(budget);
        saveTransaction(transaction);

        BigDecimal transactionSum = transaction.getSum();

        if (transaction.getType().equals("Withdrawal")) {
            budget.setBudgetMoney(budget.getBudgetMoney().subtract(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().subtract(transactionSum));
            int numberOfCategories = budgetCategories.size();
            if (numberOfCategories > 0) {
                BigDecimal amountToRestFromEachCategory = transactionSum.divide(BigDecimal.valueOf(numberOfCategories), 2,
                        RoundingMode.CEILING);
                budgetCategories
                        .forEach(category -> category.setMoneyLeft(category.getMoneyLeft().subtract(amountToRestFromEachCategory)));
                budgetCategories
                        .forEach(category -> category.setCategoryBudget(category.getCategoryBudget().subtract(amountToRestFromEachCategory)));
            }
        } else {
            budget.setBudgetMoney(budget.getBudgetMoney().add(transaction.getSum()));
            budget.setMoneyLeft(budget.getMoneyLeft().add(transaction.getSum()));
        }
        transaction.setCurrentBalance(budget.getMoneyLeft());
        transaction.setDate(LocalDate.now());
        addTransactionToBudget(transaction, budget);
    }

    public void saveTransaction(Transaction transaction) {
        transactionRepository.save(transaction);
    }

    private Transaction setNewTransaction(TransactionDto transactionDto, User user) {
        Transaction transaction = new Transaction();
        transaction.setTitle(transactionDto.getTitle());
        transaction.setSum(transactionDto.getSum());
        transaction.setType(transactionDto.getType());
        transaction.setUser(user);
        return transaction;
    }

    private void addTransactionToBudget(Transaction transaction, Budget budget) {
        SortedSet<Transaction> budgetTransactions = budget.getTransactions();
        budgetTransactions.add(transaction);
        budgetService.saveBudget(budget);
    }

    private void addTransactionToCategory(Transaction transaction, Category category) {
        SortedSet<Transaction> categoryTransactions = category.getTransactions();
        categoryTransactions.add(transaction);
        category.setTransactions(categoryTransactions);
        categoryService.saveCategory(category);
    }
}
