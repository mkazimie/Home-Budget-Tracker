package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.BudgetRepository;
import com.example.budgetary.repository.CategoryRepository;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.SortedSet;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;

    public TransactionService(TransactionRepository transactionRepository) {
        this.transactionRepository = transactionRepository;
    }

    public Transaction findTransactionById(Long id) {
        Optional<Transaction> transaction = transactionRepository.findById(id);
        return transaction.orElseThrow(() -> new NoRecordFoundException("No record found in our DB"));
    }

    public void saveTransaction(Transaction transaction) {
        transactionRepository.save(transaction);
    }

    public SortedSet<Transaction> addTransactionToCategory(TransactionDto transactionDto, Category category,
                                                           User user) {
        Budget budget = category.getBudget();
        Transaction transaction = setNewTransaction(transactionDto, user);
        transaction.setCategory(category);
        transaction.setBudget(budget);
        saveTransaction(transaction);
        return category.getTransactions();
    }

    public void updateTransaction(Long transactionId, String title, BigDecimal sum,
                                         LocalDate date) {
        Transaction transaction = findTransactionById(transactionId);
        transaction.setTitle(title);
        transaction.setSum(sum);
        transaction.setDate(date);
        saveTransaction(transaction);
    }

    public void removeTransaction(Long transactionId) {
        Transaction transaction = findTransactionById(transactionId);
        Budget budget = transaction.getBudget();
        if (transaction.getCategory() != null){
            Category transactionCategory = transaction.getCategory();
            transactionCategory.getTransactions().remove(transaction);
        }
        User user = transaction.getUser();
        user.getTransactions().remove(transaction);
        budget.getTransactions().remove(transaction);
        transactionRepository.delete(transaction);
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