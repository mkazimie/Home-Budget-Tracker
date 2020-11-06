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

import javax.validation.Valid;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

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
                                             @ModelAttribute(value = "transactionDto") @Valid TransactionDto transactionDto,
                                             BindingResult bindingResult) {
        ValidationResponse response = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            CategoryController.validateViaAjax(bindingResult, response);
        } else {
            response.setStatus("SUCCESS");
            Category transactionCategory = categoryService.findCategoryById(categoryId);
            transactionService.addTransactionToCategory(transactionDto,
                    transactionCategory);
        }
        return response;
    }

    @DeleteMapping("/categories/{categoryId}/transactions/{transactionId}")
    public @ResponseBody ValidationResponse deleteTransactionViaAjax(@PathVariable Long transactionId){
        ValidationResponse response = new ValidationResponse();
        transactionService.removeTransaction(transactionId);
        response.setStatus("SUCCESS");
        return response;
    }

    @PutMapping("/categories/{categoryId}/transactions/{id}")
    public @ResponseBody
    ValidationResponse updateTransactionViaAjax(@ModelAttribute(value = "transactionDto") @Valid Transaction transaction,
                                             BindingResult bindingResult) {
        ValidationResponse response = new ValidationResponse();
        if (bindingResult.hasErrors()) {
            CategoryController.validateViaAjax(bindingResult, response);
        } else {
            response.setStatus("SUCCESS");
            transactionService.saveTransaction(transaction);
        }
        return response;
    }
}