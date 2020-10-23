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
import java.time.LocalDate;
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
        Map<String, BigDecimal> categoryBalanceMap = balanceMap(budget);
        model.addAttribute("categoryBalanceMap", categoryBalanceMap);
        model.addAttribute("budget", budget);
        CategoryDto categoryDto = new CategoryDto();
        if (!model.containsAttribute("categoryDto")) {
            model.addAttribute("categoryDto", categoryDto);
        }
        return "categories";
    }

    @PostMapping("")
    public String addCategory(@AuthenticationPrincipal CurrentUser currentUser,
                              @ModelAttribute("categoryDto") @Valid CategoryDto categoryDto,
                              BindingResult bindingResult,
                              Model model, @PathVariable Long budgetId, RedirectAttributes attr) {
        if (!bindingResult.hasErrors()) {
            boolean categoryNameValid = checkIfCategoryNameIsValid(categoryDto, attr, budgetId);
            if (categoryNameValid) {
                Budget budget = findBudget(budgetId);
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
    public String displayCategory(@PathVariable Long categoryId, @PathVariable Long budgetId, Model model) {
        Category category = categoryService.findCategoryById(categoryId);
        Budget budget = findBudget(budgetId);
        model.addAttribute("allCategoryExpenses", countCategoryExpenses(category));
        model.addAttribute("category", category);
        model.addAttribute("budget", budget);
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", new TransactionDto());
        }
        return "category";
    }

    @PutMapping("/{id}")
    public @ResponseBody
    ValidationResponse updateViaAjax(@ModelAttribute(value = "category") @Valid Category category,
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

    static void validateViaAjax(BindingResult bindingResult, ValidationResponse res) {
        res.setStatus("FAIL");
        List<FieldError> allErrors = bindingResult.getFieldErrors();
        final List<ErrorMessage> errorMessages = new ArrayList<>();
        for (FieldError objectError : allErrors) {
            errorMessages.add(new ErrorMessage(objectError.getField(), objectError.getDefaultMessage()));
        }
        res.setErrorMessageList(errorMessages);
    }

    @GetMapping("/{categoryId}/delete")
    public String deleteCategory(@AuthenticationPrincipal CurrentUser currentUser, @PathVariable Long categoryId) {
        categoryService.removeCategory(categoryId, currentUser.getUser());
        return "redirect:/auth/budgets/{budgetId}/categories/";
    }


    public Budget findBudget(@PathVariable Long budgetId) {
        return budgetService.findById(budgetId);
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

    @ModelAttribute("categoriesIcons")
    public Map<String, String> categories() {
        Map<String, String> catIcons = new LinkedHashMap<>();
        catIcons.put("Home", "<i class='fas fa-file-invoice'></i>");
        catIcons.put("Supermarket", "<i class='fas fa-shopping-cart'></i>");
        catIcons.put("Public Transport", "<i class='fas fa-bus-alt'></i>");
        catIcons.put("Vehicle", "<i class='fas fa-car'></i>");
        catIcons.put("Health", "<i class='fas fa-tablets'></i>");
        catIcons.put("Gym", "<i class='fas fa-dumbbell'></i>");
        catIcons.put("Going Out", "<i class='fas fa-glass-cheers'></i>");
        catIcons.put("Shopping", "<i class='fas fa-shopping-bag'></i>");
        catIcons.put("Personal Care", "<i class='fas fa-magic'></i>");
        catIcons.put("Travel", "<i class='fas fa-plane'></i>");
        catIcons.put("Other", "<i class='fas fa-atom'></i>");
        catIcons.put("Savings", "<i class='fas fa-piggy-bank'></i>");
        catIcons.put("Unexpected", "<i class='fas fa-exclamation-triangle'></i>");
        return catIcons;
    }


    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }


}
