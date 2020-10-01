package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.User;
import com.example.budgetary.repository.BudgetRepository;
import org.springframework.stereotype.Service;


import java.util.Set;

@Service
public class BudgetService {

    private final BudgetRepository budgetRepository;

    public BudgetService(BudgetRepository budgetRepository) {
        this.budgetRepository = budgetRepository;
    }

    public Set<Budget> getBudgets(User user){
        return budgetRepository.findAllByUsers(user);
    }

    public void saveBudget(Budget budget){
        budgetRepository.save(budget);
    }
}
