package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.User;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
import org.hibernate.Hibernate;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

@Controller
@RequestMapping("/auth")
public class BudgetController {

    private final BudgetService budgetService;

    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }


    @GetMapping("/budgets")
    public String displayBudgets(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        getBudgets(currentUser.getUser(), model);
        return "budgets";
    }

    @GetMapping("/budgets/form")
    public String displayBudgetForm(Model model){
        Budget budget = new Budget();
        model.addAttribute("budget", budget);
        return "budget-form";
    }

    @PostMapping("/budgets")
    public String addNewBudget(@ModelAttribute @Valid Budget budget, BindingResult bindingResult,
            @AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (!bindingResult.hasErrors()){
            budget.setUsers(new HashSet<>(Arrays.asList(currentUser.getUser())));
            budgetService.saveBudget(budget);
            getBudgets(currentUser.getUser(), model);
            return "budgets";
        }
        model.addAttribute("error", "Please try again");
        return "budget-form";
    }



    @GetMapping("/dashboard")
    public String displayDashboard() {
        return "dashboard";
    }


    private void getBudgets(User user, Model model) {
        Set<Budget> budgets = budgetService.getBudgets(user);
        model.addAttribute("budgets", budgets);
    }

    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }

}
