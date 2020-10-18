package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;

import com.example.budgetary.entity.User;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.BudgetRepository;
import org.springframework.stereotype.Service;


import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class BudgetService {

    private final BudgetRepository budgetRepository;
    private final UserService userService;

    public BudgetService(BudgetRepository budgetRepository, UserService userService) {
        this.budgetRepository = budgetRepository;
        this.userService = userService;
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


    public void removeBudget(Long id, User user) {
        Budget budget = findById(id);
        Set<User> budgetUsers = budget.getUsers();
        if (budgetUsers.size() > 1) {
            budgetUsers.remove(user);
            budget.setUsers(budgetUsers);
            saveBudget(budget);
        } else {
            budget.getUsers().forEach(user1 -> user1.getBudgets().remove(budget));
            budget.setUsers(null);
            budget.getTransactions().forEach(transaction -> transaction.setBudget(null));
            budget.getCategories().forEach(category -> category.setBudget(null));
            budget.setTransactions(null);
            budget.setCategories(null);
            deleteBudget(id);
        }
    }

    public void deleteBudget(Long id) {
        budgetRepository.delete(findById(id));
    }
}
