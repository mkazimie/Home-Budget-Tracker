package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.User;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.BudgetRepository;
import org.springframework.stereotype.Service;


import java.util.*;

@Service
public class BudgetService {

    private final BudgetRepository budgetRepository;

    public BudgetService(BudgetRepository budgetRepository) {
        this.budgetRepository = budgetRepository;
    }

    public Set<Budget> getBudgets(User user){
        return budgetRepository.findAllByUsers(user);
    }

    public void createBudget(User user, Budget budget){
        budget.setUsers(new HashSet<>(Arrays.asList(user)));
//        Category category = new Category();
//        category.setBudget(budget);
//        category.setName("Savings");
//        budget.getCategories().add(category);
//        budget.setBudgetMoney(budget.getBudgetMoney());
        saveBudget(budget);
    }


    public void saveBudget(Budget budget){
        budgetRepository.save(budget);
    }

    public int countBudgetsByUser(User user){
        return budgetRepository.countBudgetsByUsers(user);
    }

    public Budget findById(Long id){
        Optional<Budget> budget = budgetRepository.findById(id);
        return budget.orElseThrow(() -> new NoRecordFoundException("No such record in the Database"));
    }

//    public List<Category> addCategoryToBudget(Category category, Budget budget){
//        Set<Category> categories = budget.getCategories();
//        categories.add(category);
//        budget.setCategories(categories);
//        budgetRepository.save(budget);
//        List <Category> budgetCategories = new ArrayList<>(budget.getCategories());
//        Collections.sort(budgetCategories);
//        return budgetCategories;
//    }
}
