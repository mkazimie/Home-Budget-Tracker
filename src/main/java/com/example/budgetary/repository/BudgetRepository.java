package com.example.budgetary.repository;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.Set;

@Repository
public interface BudgetRepository extends JpaRepository<Budget, Long> {

    @Query("SELECT b FROM Budget b LEFT JOIN FETCH b.users u WHERE u = ?1")
    Set<Budget> findAllByUser(User user);

}