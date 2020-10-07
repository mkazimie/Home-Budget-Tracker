package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Controller
@RequestMapping("/auth/budgets")
public class BudgetController {

    private final BudgetService budgetService;

    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }


    @GetMapping("")
    public String displayBudgets(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        getBudgets(currentUser.getUser(), model);
        return "budgets";
    }

    @GetMapping("/form")
    public String displayBudgetForm(Model model) {
        Budget budget = new Budget();
        model.addAttribute("budget", budget);
        return "budget-form";
    }

    @PostMapping("")
    public String addNewBudget(@ModelAttribute @Valid Budget budget, BindingResult bindingResult,
                               @AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (!bindingResult.hasErrors()) {
            LocalDate startDate = budget.getStartDate();
            LocalDate endDate = budget.getEndDate();
            if (!(startDate.isBefore(endDate))) {
                model.addAttribute("error", "The end date must be a valid date and later than the start date");
                return "budget-form";
            }
            budgetService.createBudget(currentUser.getUser(), budget);
            getBudgets(currentUser.getUser(), model);
            return "redirect:/auth/budgets";
        }
        model.addAttribute("error", "Please try again");
        return "budget-form";
    }

    @GetMapping("/{id}")
    public String displayBudgetById(@PathVariable Long id, Model model) {
        Budget budget = budgetService.findById(id);
        BigDecimal allExpenses = countAllExpenses(budget);
        BigDecimal allCategoryBudgets = sumUpCategoryBudgets(budget);
        CategoryDto categoryDto = new CategoryDto();
        model.addAttribute("budget", budget);
        model.addAttribute("allExpenses", allExpenses);
        model.addAttribute("allCategoryBudgets", allCategoryBudgets);
        if (!model.containsAttribute("categoryDto")) {
            model.addAttribute("categoryDto", categoryDto);
        }
        return "budget";
    }


    private void getBudgets(User user, Model model) {
        Set<Budget> budgets = budgetService.getBudgets(user);
        int noOfBudgets = budgetService.countBudgetsByUser(user);
        model.addAttribute("budgets", budgets);
        model.addAttribute("noOfBudgets", noOfBudgets);
    }

    private BigDecimal sumUpCategoryBudgets(Budget budget) {
        return budget.getCategories().stream()
                .map(Category::getCategoryBudget)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    private BigDecimal countAllExpenses(Budget budget) {
        return budget.getCategories().stream()
                .flatMap(category -> category.getTransactions().stream())
                .filter(transaction -> transaction.getType().equals("Expense"))
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }


    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
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
        catNames.put("Personal Care", "<i class='fas fa-hand-sparkles'></i>");
        catNames.put("Travel", "<i class='fas fa-plane'></i>");
        catNames.put("Other", "<i class='fas fa-atom'></i>");
        catNames.put("Savings", "<i class='fas fa-piggy-bank'></i>");
        catNames.put("Unexpected", "<i class='fas fa-exclamation-triangle'></i>");
        return catNames;
    }


}
