package com.example.budgetary.repository;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    @Query("SELECT t FROM Transaction t INNER JOIN FETCH t.category c INNER JOIN FETCH c.budget b INNER JOIN FETCH b" +
            ".users u WHERE u = ?1")
    List<Transaction> findAllByBudgetUser(User user);
}