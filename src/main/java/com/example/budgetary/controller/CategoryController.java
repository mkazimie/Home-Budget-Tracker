package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.service.CategoryService;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/auth/budgets/{budgetId}/categories")
public class CategoryController {

    private final CategoryService categoryService;
    private final BudgetService budgetService;

    public CategoryController(CategoryService categoryService, BudgetService budgetService) {
        this.categoryService = categoryService;
        this.budgetService = budgetService;
    }

    @PostMapping("")
    public String addCategory(@ModelAttribute("newCategory") @Valid CategoryDto categoryDto, BindingResult bindingResult,
                              Model model, @PathVariable Long budgetId, RedirectAttributes attr) {
        if (!bindingResult.hasErrors()) {
            Budget budget = findBudget(budgetId);
            SortedSet<Category> budgetCategories = categoryService.addNewCategory(categoryDto, budget);
            model.addAttribute("budgetCategories", budgetCategories);
            model.addAttribute("budget", budget);
        } else {
            attr.addFlashAttribute("org.springframework.validation.BindingResult.categoryDto", bindingResult);
            attr.addFlashAttribute("categoryDto", categoryDto);
        }
        return "redirect:/auth/budgets/{budgetId}";
    }

    @GetMapping("/{categoryId}")
    public String displayCategory(@PathVariable Long categoryId, @PathVariable Long budgetId, Model model) {
        Category category = categoryService.findCategoryById(categoryId);
        Budget budget = findBudget(budgetId);
        BigDecimal sumOfCategoryExpenses = countCategoryExpenses(category);
        model.addAttribute("sumOfCategoryTransactions", sumOfCategoryExpenses);
        model.addAttribute("category", category);
        model.addAttribute("budget", budget);
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", new TransactionDto());
        }
        return "category";

    }

    public BigDecimal countCategoryExpenses(Category category) {
        Set<Transaction> categoryTransactions = category.getTransactions();
        return categoryTransactions.stream()
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }


    public Budget findBudget(@PathVariable Long budgetId) {
        return budgetService.findById(budgetId);
    }


}
