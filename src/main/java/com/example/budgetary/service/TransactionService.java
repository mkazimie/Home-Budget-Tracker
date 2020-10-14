package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.TransactionRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
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

    public void deleteTransaction(long id) {
        transactionRepository.delete(findTransactionById(id));
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
//            category.setCategoryBudget(category.getCategoryBudget().add(transactionSum));
        }
        transaction.setCurrentBalance(budget.getMoneyLeft());
        saveTransaction(transaction);
        return category.getTransactions();
    }

    public void removeTransaction(Long transactionId){
        Transaction transaction = findTransactionById(transactionId);
        BigDecimal transactionSum = transaction.getSum();
        Category transactionCategory = transaction.getCategory();
        Budget budget = transaction.getBudget();
        BigDecimal moneyLeftInBudget = budget.getMoneyLeft();
        BigDecimal moneyLeftInCategory = transactionCategory.getMoneyLeft();
        if (transaction.getType().equals("Withdrawal")) {
            transactionCategory.setMoneyLeft(moneyLeftInCategory.add(transactionSum));
            budget.setMoneyLeft(moneyLeftInBudget.add(transactionSum));
        } else {
            transactionCategory.setMoneyLeft(moneyLeftInCategory.subtract(transactionSum));
            budget.setMoneyLeft(moneyLeftInBudget.subtract(transactionSum));
//            category.setCategoryBudget(category.getCategoryBudget().add(transactionSum));
        }
        budget.getTransactions().remove(transaction);
        transactionCategory.getTransactions().remove(transaction);
        User user = transaction.getUser();
        user.getTransactions().remove(transaction);
        deleteTransaction(transactionId);
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
