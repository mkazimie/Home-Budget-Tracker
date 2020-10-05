package com.example.budgetary.service;

import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Set;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;
    private final CategoryService categoryService;

    public TransactionService(TransactionRepository transactionRepository, CategoryService categoryService) {
        this.transactionRepository = transactionRepository;
        this.categoryService = categoryService;
    }


    public Set<Transaction> addTransaction(TransactionDto transactionDto, Category transactionCategory, User user) {
        Transaction transaction = new Transaction();
        transaction.setTitle(transactionDto.getTitle());
//        transaction.setType(transactionDto.getType());
        transaction.setSum(transactionDto.getSum());
        transaction.setDate(transactionDto.getDate());
        transaction.setCategory(transactionCategory);
        transaction.setUser(user);
        BigDecimal transactionSum = transaction.getSum();
        BigDecimal categoryMoney = transactionCategory.getCategoryMoney();
//        String type = transaction.getType();
//        if (type.equals("Income")){
//        transactionCategory.setCategoryMoney(categoryMoney.add(transactionSum));
//        } else if (type.equals("Expense")){
        transactionCategory.setCategoryMoney(categoryMoney.subtract(transactionSum));
//        }
        saveTransaction(transaction);
        Set<Transaction> categoryTransactions = transactionCategory.getTransactions();
        categoryTransactions.add(transaction);
        transactionCategory.setTransactions(categoryTransactions);
        categoryService.saveCategory(transactionCategory);
        return categoryTransactions;
    }

    public void saveTransaction(Transaction transaction) {
        transactionRepository.save(transaction);
    }
}
