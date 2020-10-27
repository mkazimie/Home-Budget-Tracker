package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Optional;
import java.util.SortedSet;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public Category findCategoryById(Long id) {
        Optional<Category> category = categoryRepository.findById(id);
        return category.orElseThrow(() -> new NoRecordFoundException("No record found in our DB"));
    }

    public Category findCategoryByName(String name, Long budgetId) {
        return categoryRepository.findByName(name, budgetId);
    }

    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }

    public void addNewCategory(CategoryDto categoryDto, Budget budget, User user) {
        Category category = new Category();
        String categoryDtoName = categoryDto.getSelectedName();
        if (categoryDtoName.equals("customized")) {
            category.setName(categoryDto.getOwnName());
        } else {
            category.setName(categoryDtoName);
        }
        category.setCategoryAllowance(categoryDto.getCategoryAllowance());
        category.setBudget(budget);
        saveCategory(category);
    }

    public void removeCategory(Long id, User user) {
        Category category = findCategoryById(id);
        SortedSet<Transaction> categoryTransactions = category.getTransactions();
        if (categoryTransactions != null) {
            categoryTransactions.forEach(transaction -> transaction.setCategory(null));
        }
        categoryRepository.delete(category);
    }
}