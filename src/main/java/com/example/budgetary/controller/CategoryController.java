package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.service.CategoryService;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/auth/budgets")
public class CategoryController {

    private final CategoryService categoryService;
    private final BudgetService budgetService;

    public CategoryController(CategoryService categoryService, BudgetService budgetService) {
        this.categoryService = categoryService;
        this.budgetService = budgetService;
    }

    @PostMapping("/{id}/categories")
    public String addCategory(@ModelAttribute("newCategory") @Valid Category category, BindingResult bindingResult,
                              Model model,
                              @PathVariable Long id){
        if (!bindingResult.hasErrors()){
            Budget budget = budgetService.findById(id);
            category.setBudget(budget);
            categoryService.saveCategory(category);
//            Set<Category> categories = budget.getCategories();
//            List <Category> budgetCategories = new ArrayList<>(categories);
//            Collections.sort(budgetCategories);
//            model.addAttribute("budgetCategories", budgetCategories);
            model.addAttribute("budget", budget);
            return "budget";
        }
        return "budget";
    }




}
