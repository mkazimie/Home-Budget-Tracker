package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.repository.BudgetRepository;
import com.example.budgetary.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.util.SortedSet;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final BudgetService budgetService;

    public CategoryService(CategoryRepository categoryRepository, BudgetService budgetService) {
        this.categoryRepository = categoryRepository;
        this.budgetService = budgetService;
    }



    public SortedSet<Category> addNewCategory(CategoryDto categoryDto, Budget budget){
        Category category = new Category();
        category.setName(categoryDto.getName());
        category.setCategoryMoney(categoryDto.getCategoryMoney());
        category.setBudget(budget);
        saveCategory(category);
        SortedSet<Category> budgetCategories = budget.getCategories();
        budgetCategories.add(category);
        budget.setCategories(budgetCategories);
        budgetService.saveBudget(budget);
        return budgetCategories;
    }


    public void saveCategory(Category category){
        categoryRepository.save(category);
    }
}