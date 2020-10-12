package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
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

    public SortedSet<Category> addNewCategory(CategoryDto categoryDto, Budget budget) {
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
        BigDecimal budgetMoney = budget.getBudgetMoney();
        BigDecimal moneyLeftInBudget = budget.getMoneyLeft();
        budget.setBudgetMoney(budgetMoney.add(category.getCategoryBudget()));
        budget.setMoneyLeft(moneyLeftInBudget.add(category.getMoneyLeft()));
        SortedSet<Category> budgetCategories = budget.getCategories();
        budgetService.saveBudget(budget);
        return budgetCategories;
    }

    public void updateCategory(Category updatedCategory, Category originalCategory, Budget budget){
        BigDecimal updatedCatBudget = updatedCategory.getCategoryBudget();
        BigDecimal originalCatBudget = originalCategory.getCategoryBudget();
        BigDecimal catBudgetDifference = updatedCatBudget.subtract(originalCatBudget);

        originalCategory.setName(updatedCategory.getName());
        originalCategory.setCategoryBudget(updatedCategory.getCategoryBudget());
        saveCategory(originalCategory);
        budget.setMoneyLeft(budget.getMoneyLeft().add(catBudgetDifference));
        budget.setBudgetMoney(budget.getBudgetMoney().add(catBudgetDifference));
        budgetService.saveBudget(budget);
    }


    public Category findCategoryById(Long id) {
        Optional<Category> category = categoryRepository.findById(id);
        return category.orElseThrow(() -> new NoRecordFoundException("No record found in our DB"));
    }

    public Category findByName(String name, Long budgetId) {
        return categoryRepository.findByName(name, budgetId);
    }


    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }

    public void deleteCategory(Long id){
        Category categoryById = findCategoryById(id);
        //to do: remove category from budget, transactions...
        categoryRepository.delete(categoryById);
    }


}
