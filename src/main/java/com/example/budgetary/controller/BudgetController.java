package com.example.budgetary.controller;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.BudgetService;
import com.example.budgetary.util.ErrorMessage;
import com.example.budgetary.util.ValidationResponse;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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
    public String displayUserBudgets(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        fetchUserBudgets(currentUser.getUser(), model);
        return "budgets";
    }

    @PostMapping("")
    public String addNewBudget(@ModelAttribute @Valid Budget budget, BindingResult bindingResult,
                               @AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (!bindingResult.hasErrors()) {
            LocalDate startDate = budget.getStartDate();
            LocalDate endDate = budget.getEndDate();
            checkIfDateIsValid(startDate, endDate);
            if (!checkIfDateIsValid(startDate, endDate)) {
                model.addAttribute("error", "The end date must be a valid date and later than the start date");
                return "budget-form";
            }
            budgetService.createBudget(currentUser.getUser(), budget);
            fetchUserBudgets(currentUser.getUser(), model);
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
    public String displayBudgetById(@AuthenticationPrincipal CurrentUser currentUser, @PathVariable Long id,
                                    Model model) {
        boolean budgetBelongsToUser = checkIfBudgetBelongsToUser(id, currentUser.getUser());
        if (budgetBelongsToUser){
            Budget budget = budgetService.findBudgetById(id);
            model.addAttribute("categoryDto", new CategoryDto());
            if (!model.containsAttribute("transactionDto")) {
                model.addAttribute("transactionDto", new TransactionDto());
            }
            model.addAttribute("budget", budget);
            model.addAttribute("allBudgetExpenses", countAllBudgetExpenses(budget));
            model.addAttribute("budgetAllowance", countBudgetAllowance(budget));
            model.addAttribute("categoryIconsMap", CategoryController.getCategoryIconsMap());
            return "budget";
        } else {
            return "404";
        }
    }

    @PutMapping("/{id}")
    public @ResponseBody
    ValidationResponse updateBudgetViaAjax(@ModelAttribute(value = "budget") @Valid Budget budget,
                                           BindingResult bindingResult) {
        ValidationResponse response = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            CategoryController.validateViaAjax(bindingResult, response);
        } else {
            final List<ErrorMessage> errorMessageList = new ArrayList<>();
            LocalDate startDate = budget.getStartDate();
            LocalDate endDate = budget.getEndDate();
            checkIfDateIsValid(startDate, endDate);
            if (checkIfDateIsValid(startDate, endDate)) {
                response.setStatus("SUCCESS");
                budgetService.saveBudget(budget);
            } else {
                response.setStatus("FAIL");
                errorMessageList.add(new ErrorMessage("endDate", "* The end date must not precede the start date"));
            }
            response.setErrorMessageList(errorMessageList);
        }
        return response;
    }

    @GetMapping("/{id}/delete")
    public String deleteBudget(@PathVariable Long id, @AuthenticationPrincipal CurrentUser currentUser) {
        boolean budgetBelongsToUser = checkIfBudgetBelongsToUser(id, currentUser.getUser());
        if (budgetBelongsToUser){
            budgetService.removeBudget(id, currentUser.getUser());
            return "redirect:/auth/budgets";
        } else {
            return "404";
        }
    }

    private void fetchUserBudgets(User user, Model model) {
        Set<Budget> budgets = budgetService.getAllUserBudgets(user);
        model.addAttribute("budgetsAllowanceAndBalanceMap", getBudgetAllowanceAndBalanceMap(budgets));
        model.addAttribute("now", LocalDate.now());
        model.addAttribute("budgets", budgets);
    }

    private static BigDecimal countAllBudgetExpenses(Budget budget) {
        return budget.getCategories().stream()
                .flatMap(category -> category.getTransactions().stream())
                .filter(transaction -> transaction.getType().equals("Withdrawal"))
                .map(Transaction::getSum)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    private static BigDecimal countBudgetAllowance(Budget budget) {
        return budget.getCategories().stream()
                .map(Category::getCategoryAllowance)
                .reduce(new BigDecimal(0), BigDecimal::add);
    }

    private static Map<String, List<BigDecimal>> getBudgetAllowanceAndBalanceMap(Set<Budget> budgets) {
        Map<String, List<BigDecimal>> budgetAllowanceAndBalance = new HashMap<>();
        for (Budget budget : budgets) {
            BigDecimal budgetAllowance = countBudgetAllowance(budget);
            BigDecimal allBudgetExpenses = countAllBudgetExpenses(budget);
            BigDecimal budgetBalance = budgetAllowance.subtract(allBudgetExpenses);
            budgetAllowanceAndBalance.put(budget.getName(), new ArrayList<>(Arrays.asList(budgetAllowance, budgetBalance)));
        }
        return budgetAllowanceAndBalance;
    }

    private boolean checkIfBudgetBelongsToUser(Long id, User user) {
        Budget budget = budgetService.getAllUserBudgets(user).stream()
                .filter(currentUserBudget -> currentUserBudget.getId().equals(id))
                .findFirst()
                .orElse(null);
        return budget != null;
    }

    private boolean checkIfDateIsValid(LocalDate startDate, LocalDate endDate) {
        return startDate.isBefore(endDate);
    }

    @ModelAttribute("currentUser")
    public User currentUser(@AuthenticationPrincipal CurrentUser currentUser) {
        return currentUser.getUser();
    }
}