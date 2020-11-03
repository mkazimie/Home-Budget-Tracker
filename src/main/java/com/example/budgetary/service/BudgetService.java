package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;

import com.example.budgetary.entity.User;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.exception.UnauthorizedRequestException;
import com.example.budgetary.repository.BudgetRepository;
import org.springframework.stereotype.Service;


import java.util.*;

@Service
public class BudgetService {

    private final BudgetRepository budgetRepository;

    public BudgetService(BudgetRepository budgetRepository) {
        this.budgetRepository = budgetRepository;
    }

    public Set<Budget> getAllUserBudgets(User user) {
        return budgetRepository.findAllByUser(user);
    }

    public Budget findBudgetById(Long id) {
        Optional<Budget> budget = budgetRepository.findById(id);
        return budget.orElseThrow(() -> new NoRecordFoundException("No such record in the Database"));
    }

    public void createBudget(User user, Budget budget) {
        budget.setUsers(new HashSet<>(Arrays.asList(user)));
        saveBudget(budget);
    }

    public void saveBudget(Budget budget) {
        budgetRepository.save(budget);
    }

    public void removeBudget(Long id, User user) {
        Budget budget = findBudgetById(id);
        Set<User> budgetUsers = budget.getUsers();
        if (budgetUsers.size() > 1) {
            budgetUsers.remove(user);
            budget.setUsers(budgetUsers);
            saveBudget(budget);
        } else {
            budget.getUsers().forEach(budgetUser -> budgetUser.getBudgets().remove(budget));
            budget.setUsers(null);
            budget.getCategories().forEach(category -> category.setBudget(null));
            budget.setCategories(null);
            budgetRepository.delete(budget);
        }
    }
}