package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
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
@RequestMapping("/auth/budgets")
public class BudgetController {

    private final BudgetService budgetService;

    public BudgetController(BudgetService budgetService) {
        this.budgetService = budgetService;
    }


    @GetMapping("")
    public String displayBudgets(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        getAllUserBudgets(currentUser.getUser(), model);
        return "budgets";
    }

    @PostMapping("")
    public String addNewBudget(@ModelAttribute @Valid Budget budget, BindingResult bindingResult,
                               @AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (!bindingResult.hasErrors()) {
            LocalDate startDate = budget.getStartDate();
            LocalDate endDate = budget.getEndDate();
            validDate(startDate, endDate);
            if (!validDate(startDate, endDate)) {
                model.addAttribute("error", "The end date must be a valid date and later than the start date");
                return "budget-form";
            }
            budgetService.createBudget(currentUser.getUser(), budget);
            getAllUserBudgets(currentUser.getUser(), model);
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
    public String displayBudgetById(@PathVariable Long id, Model model, HttpServletRequest request) {
        Budget budget = budgetService.findById(id);
        BigDecimal allExpenses = countAllExpenses(budget);
        request.getSession().setAttribute("allExpenses", allExpenses);

        TransactionDto transactionDto = new TransactionDto();
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", transactionDto);
        }
        model.addAttribute("budget", budget);
        model.addAttribute("allExpenses", allExpenses);
        return "budget";
    }

    @PutMapping("/{id}")
    public @ResponseBody ValidationResponse updateViaAjax(@ModelAttribute(value="budget") @Valid Budget budget,
                                    BindingResult bindingResult) {
        ValidationResponse res = new ValidationResponse();
        if(bindingResult.hasErrors()){
            CategoryController.validateViaAjax(bindingResult, res);
        } else {
            final List<ErrorMessage> errorMessageList = new ArrayList<>();

            LocalDate startDate = budget.getStartDate();
            LocalDate endDate = budget.getEndDate();
            validDate(startDate, endDate);
            if (validDate(startDate, endDate)){
                res.setStatus("SUCCESS");
                budgetService.saveBudget(budget);
            } else {
                res.setStatus("FAIL");
                errorMessageList.add(new ErrorMessage("endDate", "The end date cannot precede the start date"));
            }
            res.setErrorMessageList(errorMessageList);
        }
        return res;
    }



    @GetMapping("/{id}/delete")
    public String deleteBudget(@PathVariable Long id, @AuthenticationPrincipal CurrentUser currentUser) {
        budgetService.removeBudget(id, currentUser.getUser());
        return "redirect:/auth/budgets";
    }


    private void getAllUserBudgets(User user, Model model) {
        Set<Budget> budgets = budgetService.getBudgets(user);
        int noOfBudgets = budgetService.countBudgetsByUser(user);
        model.addAttribute("now", LocalDate.now());
        model.addAttribute("budgets", budgets);
        model.addAttribute("noOfBudgets", noOfBudgets);
    }


    private BigDecimal countAllExpenses(Budget budget) {
        return budget.getCategories().stream()
                .flatMap(category -> category.getTransactions().stream())
                .filter(transaction -> transaction.getType().equals("Withdrawal"))
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    private boolean validDate(LocalDate startDate, LocalDate endDate) {
        return startDate.isBefore(endDate);
    }


    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }


}
