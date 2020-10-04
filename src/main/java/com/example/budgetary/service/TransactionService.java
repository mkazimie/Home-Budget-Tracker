package com.example.budgetary.service;

import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;
    private final CategoryService categoryService;

    public TransactionService(TransactionRepository transactionRepository, CategoryService categoryService) {
        this.transactionRepository = transactionRepository;
        this.categoryService = categoryService;
    }


    public Set<Transaction> addTransaction(TransactionDto transactionDto, Category transactionCategory){
        Transaction transaction = new Transaction();
        transaction.setTitle(transactionDto.getTitle());
        transaction.setType(transactionDto.getType());
        transaction.setSum(transactionDto.getSum());
        transaction.setDate(transactionDto.getDate());
        transaction.setCategory(transactionCategory);
        saveTransaction(transaction);
        Set<Transaction> categoryTransactions = transactionCategory.getTransactions();
        categoryTransactions.add(transaction);
        transactionCategory.setTransactions(categoryTransactions);
        categoryService.saveCategory(transactionCategory);
        return categoryTransactions;
    }

    public void saveTransaction(Transaction transaction){
        transactionRepository.save(transaction);
    }
}
