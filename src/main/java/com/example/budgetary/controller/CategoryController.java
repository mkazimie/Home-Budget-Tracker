package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.service.CategoryService;
import com.example.budgetary.util.ErrorMessage;
import com.example.budgetary.util.ValidationResponse;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String displayBudgetCategories(@PathVariable Long budgetId, Model model, HttpServletRequest request) {
        Budget budget = fetchBudget(budgetId);
        Map<String, BigDecimal> categoryBalanceMap = calculateCategoryBalance(budget);
        model.addAttribute("categoryBalanceMap", categoryBalanceMap);
        model.addAttribute("budget", budget);
        CategoryDto categoryDto = new CategoryDto();
        if (!model.containsAttribute("categoryDto")) {
            model.addAttribute("categoryDto", categoryDto);
        }
        return "categories";
    }

    @PostMapping("")
    public @ResponseBody
    ValidationResponse addCategoryViaAjax(@AuthenticationPrincipal CurrentUser currentUser, @PathVariable Long budgetId,
                                          @ModelAttribute(value = "categoryDto") @Valid CategoryDto categoryDto,
                                          BindingResult bindingResult) {
        ValidationResponse res = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            CategoryController.validateViaAjax(bindingResult, res);
        } else {
            final List<ErrorMessage> errorMessages = new ArrayList<>();
            boolean categoryNameIsValid = checkIfCategoryNameIsValid(categoryDto, errorMessages, res, budgetId);
            if (categoryNameIsValid) {
                res.setStatus("SUCCESS");
                Budget budget = fetchBudget(budgetId);
                categoryService.addNewCategory(categoryDto, budget, currentUser.getUser());
            } else {
                res.setStatus("FAIL");
            }
        }
        return res;
    }

    private boolean checkIfCategoryNameIsValid(CategoryDto categoryDto, List<ErrorMessage> errorMessages, ValidationResponse response, Long budgetId) {
        boolean isValid = true;
        String selectedName = categoryDto.getSelectedName();
        String ownName = categoryDto.getOwnName();
        if (categoryService.findCategoryByName(selectedName, budgetId) != null || ((ownName != null && categoryService.findCategoryByName(ownName, budgetId) != null))) {
            errorMessages.add(new ErrorMessage("generalError", "* Such category already exists in your budget"));
            isValid = false;
        } else if (selectedName.equals("customized") && ownName.trim().isEmpty()) {
            errorMessages.add(new ErrorMessage("ownName", "* Please name your custom category"));
            isValid = false;
        }
        response.setErrorMessageList(errorMessages);
        return isValid;
    }

    @GetMapping("/{categoryId}")
    public String displayCategoryById(@PathVariable Long categoryId, @PathVariable Long budgetId, Model model) {
        Category category = categoryService.findCategoryById(categoryId);
        Budget budget = fetchBudget(budgetId);
        model.addAttribute("allCategoryExpenses", countAllCategoryExpenses(category));
        model.addAttribute("category", category);
        model.addAttribute("budget", budget);
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", new TransactionDto());
        }
        return "category";
    }

    @PutMapping("/{id}")
    public @ResponseBody
    ValidationResponse updateCategoryViaAjax(@ModelAttribute(value = "category") @Valid Category category,
                                             BindingResult bindingResult) {
        ValidationResponse res = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            validateViaAjax(bindingResult, res);
        } else {
            final List<ErrorMessage> errorMessageList = new ArrayList<>();
            Category existingCategory = categoryService.findCategoryByName(category.getName(), category.getBudget().getId());
            if (existingCategory == null || existingCategory.getId() == category.getId()) {
                res.setStatus("SUCCESS");
                categoryService.saveCategory(category);
            } else {
                res.setStatus("FAIL");
                errorMessageList.add(new ErrorMessage("name", "Such category already exists in you budget"));
            }
            res.setErrorMessageList(errorMessageList);
        }
        return res;
    }

    @GetMapping("/{categoryId}/delete")
    public String deleteCategory(@AuthenticationPrincipal CurrentUser currentUser, @PathVariable Long categoryId) {
        categoryService.removeCategory(categoryId, currentUser.getUser());
        return "redirect:/auth/budgets/{budgetId}/categories/";
    }

    static void validateViaAjax(BindingResult bindingResult, ValidationResponse res) {
        res.setStatus("FAIL");
        List<FieldError> allErrors = bindingResult.getFieldErrors();
        final List<ErrorMessage> errorMessages = new ArrayList<>();
        for (FieldError objectError : allErrors) {
            errorMessages.add(new ErrorMessage(objectError.getField(), objectError.getDefaultMessage()));
        }
        res.setErrorMessageList(errorMessages);
    }

    public Budget fetchBudget(@PathVariable Long budgetId) {
        return budgetService.findBudgetById(budgetId);
    }

    public BigDecimal countAllCategoryExpenses(Category category) {
        SortedSet<Transaction> transactions = category.getTransactions();
        return transactions.stream()
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    private Map<String, BigDecimal> calculateCategoryBalance(Budget budget) {
        Map<String, BigDecimal> balanceMap = new HashMap<>();
        SortedSet<Category> categories = budget.getCategories();
        for (Category category : categories) {
            balanceMap.put(category.getName(),
                    category.getCategoryBudget().subtract(countAllCategoryExpenses(category)));
        }
        return balanceMap;
    }

    @ModelAttribute("transactionType")
    public List<String> status() {
        return Arrays.asList("Deposit", "Withdrawal");
    }

    @ModelAttribute("categoryIconsMap")
    public static Map<String, String> getCategoryIconsMap() {
        Map<String, String> categoryIcons = new LinkedHashMap<>();
        categoryIcons.put("Home", "<i class='fas fa-file-invoice'></i>");
        categoryIcons.put("Supermarket", "<i class='fas fa-shopping-cart'></i>");
        categoryIcons.put("Public Transport", "<i class='fas fa-bus-alt'></i>");
        categoryIcons.put("Vehicle", "<i class='fas fa-car'></i>");
        categoryIcons.put("Health", "<i class='fas fa-tablets'></i>");
        categoryIcons.put("Gym", "<i class='fas fa-dumbbell'></i>");
        categoryIcons.put("Going Out", "<i class='fas fa-glass-cheers'></i>");
        categoryIcons.put("Shopping", "<i class='fas fa-shopping-bag'></i>");
        categoryIcons.put("Personal Care", "<i class='fas fa-magic'></i>");
        categoryIcons.put("Travel", "<i class='fas fa-plane'></i>");
        categoryIcons.put("Other", "<i class='fas fa-atom'></i>");
        categoryIcons.put("Savings", "<i class='fas fa-piggy-bank'></i>");
        categoryIcons.put("Unexpected", "<i class='fas fa-exclamation-triangle'></i>");
        return categoryIcons;
    }

    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }
}