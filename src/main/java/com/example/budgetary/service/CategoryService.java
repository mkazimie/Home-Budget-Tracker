package com.example.budgetary.service;

import com.example.budgetary.entity.Category;
import com.example.budgetary.repository.CategoryRepository;
import org.springframework.stereotype.Service;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public Category saveCategory(Category category){
        return categoryRepository.save(category);
    }
}
