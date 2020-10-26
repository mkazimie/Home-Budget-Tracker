package com.example.budgetary.controller;

import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.CategoryService;
import com.example.budgetary.service.TransactionService;
import com.example.budgetary.util.ErrorMessage;
import com.example.budgetary.util.ValidationResponse;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.SortedSet;

@Controller
@RequestMapping("/auth/budgets/{budgetId}")
public class TransactionController {

    private final TransactionService transactionService;
    private final CategoryService categoryService;

    public TransactionController(TransactionService transactionService, CategoryService categoryService) {
        this.transactionService = transactionService;
        this.categoryService = categoryService;
    }

    @PostMapping("/categories/{categoryId}/transactions") public @ResponseBody
    ValidationResponse addTransactionViaAjax(@PathVariable Long categoryId,
                                             @AuthenticationPrincipal CurrentUser currentUser,
                                             @ModelAttribute(value = "transactionDto") @Valid TransactionDto transactionDto,
                                             BindingResult bindingResult) {
        ValidationResponse res = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            CategoryController.validateViaAjax(bindingResult, res);
        } else {
            res.setStatus("SUCCESS");
            Category transactionCategory = categoryService.findCategoryById(categoryId);
            SortedSet<Transaction> categoryTransactions = transactionService.addTransactionToCategory(transactionDto,
                    transactionCategory, currentUser.getUser());
        }
        return res;
    }

    @GetMapping("/categories/{categoryId}/transactions/{transactionId}")
    public String deleteTransactionFromCategory(@PathVariable Long categoryId, @PathVariable Long transactionId){
        transactionService.removeTransaction(transactionId);
        return "redirect:/auth/budgets/{budgetId}/categories/{categoryId}";
    }

    @GetMapping("/transactions/{transactionId}")
    public String deleteTransactionFromBudget(@PathVariable Long transactionId){
        transactionService.removeTransaction(transactionId);
        return "redirect:/auth/budgets/{budgetId}";
    }

    @PostMapping("/categories/{categoryId}/transactions/{transactionId}/update")
    public String updateTransaction(@PathVariable Long categoryId, @PathVariable Long transactionId,
                                    Model model, @RequestParam String title, @RequestParam BigDecimal sum,
                                    @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date){
        transactionService.updateTransaction(transactionId, title, sum, date);

        return "redirect:/auth/budgets/{budgetId}/categories/{categoryId}";
    }
}