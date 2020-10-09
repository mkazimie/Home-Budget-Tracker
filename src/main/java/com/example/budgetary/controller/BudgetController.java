package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.service.TransactionService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/auth/budgets")
public class BudgetController {

    private final BudgetService budgetService;
    private final TransactionService transactionService;

    public BudgetController(BudgetService budgetService, TransactionService transactionService) {
        this.budgetService = budgetService;
        this.transactionService = transactionService;
    }


    @GetMapping("")
    public String displayBudgets(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        getBudgets(currentUser.getUser(), model);
        return "budgets";
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

    @GetMapping("/form")
    public String displayBudgetForm(Model model) {
        Budget budget = new Budget();
        model.addAttribute("budget", budget);
        return "budget-form";
    }

    @GetMapping("/{id}")
    public String displayBudgetById(@PathVariable Long id, Model model) {
        Budget budget = budgetService.findById(id);
        BigDecimal allExpenses = countAllExpenses(budget);
        TransactionDto transactionDto = new TransactionDto();
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", transactionDto);
        }
        model.addAttribute("budget", budget);
        model.addAttribute("allExpenses", allExpenses);
        return "budget";
    }

    @PostMapping("/{id}")
    public String saveBudgetTransaction(@ModelAttribute @Valid TransactionDto transactionDto,
                                        BindingResult bindingResult, RedirectAttributes attr,
                                        @AuthenticationPrincipal CurrentUser currentUser, @PathVariable Long id,
                                        Model model){
        if (!bindingResult.hasErrors()){
            Budget budget = budgetService.findById(id);
            transactionService.makeTransactionOnBudget(transactionDto, currentUser.getUser(), budget);
        } else {
            attr.addFlashAttribute("org.springframework.validation.BindingResult.transactionDto", bindingResult);
            attr.addFlashAttribute("transactionDto", transactionDto);
        }
        return "redirect:/auth/budgets/{id}";
    }


    private void getBudgets(User user, Model model) {
        Set<Budget> budgets = budgetService.getBudgets(user);
        int noOfBudgets = budgetService.countBudgetsByUser(user);
        model.addAttribute("budgets", budgets);
        model.addAttribute("noOfBudgets", noOfBudgets);
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

    @ModelAttribute("transactionType")
    public List<String> chooseTransactionType() {
        return Arrays.asList("Income", "Expense");
    }


}
