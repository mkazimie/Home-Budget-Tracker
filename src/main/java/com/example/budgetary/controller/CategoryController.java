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
    public String addNewCategory(@AuthenticationPrincipal CurrentUser currentUser,
                              @ModelAttribute("categoryDto") @Valid CategoryDto categoryDto,
                              BindingResult bindingResult,
                              Model model, @PathVariable Long budgetId, RedirectAttributes attr) {
        if (!bindingResult.hasErrors()) {
            boolean categoryNameValid = checkIfCategoryNameIsValid(categoryDto, attr, budgetId);
            if (categoryNameValid) {
                Budget budget = fetchBudget(budgetId);
                SortedSet<Category> budgetCategories = categoryService.addNewCategory(categoryDto, budget, currentUser.getUser());
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
            Category existingCategory = categoryService.findByName(category.getName(), category.getBudget().getId());
            if (existingCategory == null || existingCategory.getId()==category.getId()) {
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
        return budgetService.findById(budgetId);
    }


    public BigDecimal countAllCategoryExpenses(Category category) {
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

    @ModelAttribute("categoryIconMap")
    public Map<String, String> categories() {
        Map<String, String> categoriesIcons = new LinkedHashMap<>();
        categoriesIcons.put("Home", "<i class='fas fa-file-invoice'></i>");
        categoriesIcons.put("Supermarket", "<i class='fas fa-shopping-cart'></i>");
        categoriesIcons.put("Public Transport", "<i class='fas fa-bus-alt'></i>");
        categoriesIcons.put("Vehicle", "<i class='fas fa-car'></i>");
        categoriesIcons.put("Health", "<i class='fas fa-tablets'></i>");
        categoriesIcons.put("Gym", "<i class='fas fa-dumbbell'></i>");
        categoriesIcons.put("Going Out", "<i class='fas fa-glass-cheers'></i>");
        categoriesIcons.put("Shopping", "<i class='fas fa-shopping-bag'></i>");
        categoriesIcons.put("Personal Care", "<i class='fas fa-magic'></i>");
        categoriesIcons.put("Travel", "<i class='fas fa-plane'></i>");
        categoriesIcons.put("Other", "<i class='fas fa-atom'></i>");
        categoriesIcons.put("Savings", "<i class='fas fa-piggy-bank'></i>");
        categoriesIcons.put("Unexpected", "<i class='fas fa-exclamation-triangle'></i>");
        return categoriesIcons;
    }


    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }


}
