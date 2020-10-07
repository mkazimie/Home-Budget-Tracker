package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.BudgetRepository;
import com.example.budgetary.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Optional;
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
        String categoryDtoName = categoryDto.getSelectedName();
        if (categoryDtoName.equals("customized")) {
            category.setName(categoryDto.getOwnName());
        } else {
            category.setName(categoryDtoName);
        }
        category.setCategoryBudget(categoryDto.getCategoryMoney());
        category.setMoneyLeft(categoryDto.getCategoryMoney());
        category.setBudget(budget);
        saveCategory(category);
        SortedSet<Category> budgetCategories = budget.getCategories();
        budgetCategories.add(category);
        budget.setCategories(budgetCategories);
        budgetService.saveBudget(budget);
        return budgetCategories;
    }

    public Category findCategoryById(Long id){
        Optional<Category> category = categoryRepository.findById(id);
        return category.orElseThrow(() -> new NoRecordFoundException("No record found in our DB"));
    }


    public void saveCategory(Category category){
        categoryRepository.save(category);
    }
}
