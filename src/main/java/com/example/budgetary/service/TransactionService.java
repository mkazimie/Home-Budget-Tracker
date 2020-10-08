package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Set;
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


    public Set<Transaction> addTransaction(TransactionDto transactionDto, Category transactionCategory, User user) {
        Transaction transaction = new Transaction();
        transaction.setTitle(transactionDto.getTitle());
        transaction.setSum(transactionDto.getSum());
        transaction.setDate(transactionDto.getDate());
        transaction.setType(transactionDto.getType());
        transaction.setCategory(transactionCategory);
        transaction.setUser(user);
        BigDecimal transactionSum = transaction.getSum();
        BigDecimal moneyLeft = transactionCategory.getMoneyLeft();
        Budget budget = transactionCategory.getBudget();
        if (transaction.getType().equals("Expense")) {
            transactionCategory.setMoneyLeft(moneyLeft.subtract(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().subtract(transactionSum));
        } else {
            transactionCategory.setMoneyLeft(moneyLeft.add(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().add(transactionSum));
            transactionCategory.setCategoryBudget(transactionCategory.getCategoryBudget().add(transactionSum));
        }
        saveTransaction(transaction);
        Set<Transaction> categoryTransactions = transactionCategory.getTransactions();
        categoryTransactions.add(transaction);
        transactionCategory.setTransactions(categoryTransactions);
        categoryService.saveCategory(transactionCategory);
        return categoryTransactions;
    }

    public SortedSet<Transaction> addIncome(TransactionDto transactionDto, User user, Long budgetId){
        Budget budget = budgetService.findById(budgetId);
        Transaction transaction = new Transaction();
        transaction.setSum(transactionDto.getSum());
        transaction.setType(transactionDto.getType());
        transaction.setTitle(transactionDto.getTitle());
        transaction.setBudget(budget);
        transaction.setUser(user);
        saveTransaction(transaction);
        SortedSet<Transaction> transactions = budget.getTransactions();
        transactions.add(transaction);
        budgetService.saveBudget(budget);
        return transactions;
    }

    public void saveTransaction(Transaction transaction) {
        transactionRepository.save(transaction);
    }
}
