package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.SortedSet;


@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;


    public TransactionService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }


    public SortedSet<Transaction> addTransaction(TransactionDto transactionDto, Category category,
                                                            User user) {
        Budget budget = category.getBudget();

        Transaction transaction = setNewTransaction(transactionDto, user);
        transaction.setCategory(category);
        transaction.setBudget(budget);

        BigDecimal transactionSum = transaction.getSum();
        BigDecimal moneyLeftInCategory = category.getMoneyLeft();

        if (transaction.getType().equals("Withdrawal")) {
            category.setMoneyLeft(moneyLeftInCategory.subtract(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().subtract(transactionSum));
        } else {
            category.setMoneyLeft(moneyLeftInCategory.add(transactionSum));
            budget.setMoneyLeft(budget.getMoneyLeft().add(transactionSum));
            category.setCategoryBudget(category.getCategoryBudget().add(transactionSum));
        }
        transaction.setCurrentBalance(budget.getMoneyLeft());
        saveTransaction(transaction);
        return category.getTransactions();
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
        transaction.setDate(transactionDto.getDate());
        return transaction;
    }

}
