package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.service.CategoryService;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.persistence.ManyToOne;
import javax.servlet.http.HttpServletRequest;
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

    @GetMapping("")
    public String displayCategories(@PathVariable Long budgetId, Model model, HttpServletRequest request) {
        Budget budget = findBudget(budgetId);
        BigDecimal allCategoryBudgets = sumUpCategoryBudgets(budget);
        Map<String, BigDecimal> categoryBalanceMap = balanceMap(budget);
        model.addAttribute("categoryBalanceMap", categoryBalanceMap);
        request.getSession().setAttribute("allCategoryBudgets", allCategoryBudgets);
        CategoryDto categoryDto = new CategoryDto();
        model.addAttribute("allExpenses", request.getSession().getAttribute("allExpenses"));
        model.addAttribute("budget", budget);
        model.addAttribute("allCategoryBudgets", allCategoryBudgets);
        if (!model.containsAttribute("categoryDto")) {
            model.addAttribute("categoryDto", categoryDto);
        }
        return "categories";
    }

    @PostMapping("")
    public String addCategory(@ModelAttribute("categoryDto") @Valid CategoryDto categoryDto,
                              BindingResult bindingResult,
                              Model model, @PathVariable Long budgetId, RedirectAttributes attr) {
        if (!bindingResult.hasErrors()) {
            boolean categoryNameValid = checkIfCategoryNameIsValid(categoryDto, attr, budgetId);
            if (categoryNameValid) {
                Budget budget = findBudget(budgetId);
                SortedSet<Category> budgetCategories = categoryService.addNewCategory(categoryDto, budget);
                model.addAttribute("budgetCategories", budgetCategories);
                model.addAttribute("budget", budget);
            }
        } else {
            attr.addFlashAttribute("org.springframework.validation.BindingResult.categoryDto", bindingResult);
            attr.addFlashAttribute("categoryDto", categoryDto);
        }
        return "redirect:/auth/budgets/{budgetId}/categories";
    }

    @GetMapping("/{categoryId}")
    public String displayCategory(@PathVariable Long categoryId, @PathVariable Long budgetId, Model model,
                                  HttpServletRequest request) {
        Category category = categoryService.findCategoryById(categoryId);
        Budget budget = findBudget(budgetId);
        model.addAttribute("allCategoryExpenses", countCategoryExpenses(category));
        model.addAttribute("category", category);
        model.addAttribute("budget", budget);
        model.addAttribute("allCategoryBudgets", request.getSession().getAttribute("allCategoryBudgets"));
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", new TransactionDto());
        }
        if (!model.containsAttribute("category")) {
            model.addAttribute("category", new Category());
        }
        return "category";
    }

    @PostMapping("/{categoryId}")
    public String updateCategory(@ModelAttribute @Valid Category category,
                                 BindingResult bindingResult, @PathVariable Long categoryId,
                                 @PathVariable Long budgetId,
                                 Model model, RedirectAttributes attr) {
        if (!bindingResult.hasErrors()) {
            Category categoryById = categoryService.findCategoryById(categoryId);
            categoryById.setName(category.getName());
            categoryById.setCategoryBudget(category.getCategoryBudget());
            categoryService.saveCategory(categoryById);
        } else {
            attr.addFlashAttribute("org.springframework.validation.BindingResult.category", bindingResult);
            attr.addFlashAttribute("category", category);
        }
        return "redirect:/auth/budgets/{budgetId}/categories/{categoryId}";
    }


    public Budget findBudget(@PathVariable Long budgetId) {
        return budgetService.findById(budgetId);
    }


    private BigDecimal sumUpCategoryBudgets(Budget budget) {
        return budget.getCategories().stream()
                .map(Category::getCategoryBudget)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    public BigDecimal countCategoryExpenses(Category category) {
        SortedSet<Transaction> transactions = category.getTransactions();
        return transactions.stream()
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }


    private boolean checkIfCategoryNameIsValid(CategoryDto categoryDto, RedirectAttributes attr, Long budgetId) {
        boolean isValid;
        String selectedName = categoryDto.getSelectedName();
        String ownName = categoryDto.getOwnName();
        if (categoryService.findByName(selectedName, budgetId) != null || ((ownName != null && categoryService.findByName(ownName, budgetId) != null))) {
            attr.addFlashAttribute("error", "Such category already exists in your budget");
            isValid = false;
        } else if (selectedName.equals("customized") && ownName.trim().isEmpty()) {
            attr.addFlashAttribute("error", "Please name your customized category");
            isValid = false;
        } else {
            isValid = true;
        }
        return isValid;
    }


    private Map<String, BigDecimal> balanceMap(Budget budget) {
        Map<String, BigDecimal> balanceMap = new HashMap<>();
        SortedSet<Category> categories = budget.getCategories();
        for (Category category : categories) {
            balanceMap.put(category.getName(),
                    category.getCategoryBudget().subtract(countCategoryExpenses(category)));
        }
        return balanceMap;
    }

    @ModelAttribute("transactionType")
    public List<String> status() {
        return Arrays.asList("Deposit", "Withdrawal");
    }

    @ModelAttribute("catName")
    public Map<String, String> categories() {
        Map<String, String> catNames = new LinkedHashMap<>();
        catNames.put("Home Expenses", "<i class='fas fa-file-invoice'></i>");
        catNames.put("Supermarket", "<i class='fas fa-shopping-cart'></i>");
        catNames.put("Public Transport", "<i class='fas fa-bus-alt'></i>");
        catNames.put("Vehicle", "<i class='fas fa-car'></i>");
        catNames.put("Health", "<i class='fas fa-tablets'></i>");
        catNames.put("Gym", "<i class='fas fa-dumbbell'></i>");
        catNames.put("Going Out", "<i class='fas fa-glass-cheers'></i>");
        catNames.put("Shopping", "<i class='fas fa-shopping-bag'></i>");
        catNames.put("Personal Care", "<i class='fas fa-magic'></i>");
        catNames.put("Travel", "<i class='fas fa-plane'></i>");
        catNames.put("Other", "<i class='fas fa-atom'></i>");
        catNames.put("Savings", "<i class='fas fa-piggy-bank'></i>");
        catNames.put("Unexpected", "<i class='fas fa-exclamation-triangle'></i>");
        return catNames;
    }

}
