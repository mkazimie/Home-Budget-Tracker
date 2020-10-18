package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.User;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.BudgetRepository;
import org.springframework.stereotype.Service;


import java.math.BigDecimal;
import java.util.*;

@Service
public class BudgetService {

    private final BudgetRepository budgetRepository;

    public BudgetService(BudgetRepository budgetRepository) {
        this.budgetRepository = budgetRepository;
    }

    public Set<Budget> getBudgets(User user) {
        return budgetRepository.findAllByUsers(user);
    }

    public int countBudgetsByUser(User user) {
        return budgetRepository.countBudgetsByUsers(user);
    }


    public Budget findById(Long id) {
        Optional<Budget> budget = budgetRepository.findById(id);
        return budget.orElseThrow(() -> new NoRecordFoundException("No such record in the Database"));
    }


    public void createBudget(User user, Budget budget) {
        budget.setUsers(new HashSet<>(Arrays.asList(user)));
        budget.setBudgetMoney(BigDecimal.ZERO);
        budget.setMoneyLeft(BigDecimal.ZERO);
        saveBudget(budget);
    }


    public void saveBudget(Budget budget) {
        budgetRepository.save(budget);
    }


    public void deleteBudget(Long id){
        budgetRepository.delete(findById(id));
    }
}
