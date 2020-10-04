package com.example.budgetary.controller;

import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.service.CategoryService;
import com.example.budgetary.service.TransactionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.Set;

@Controller
@RequestMapping("/auth/budgets/{budgetId}/categories/{categoryId}/transactions")
public class TransactionController {

    private final TransactionService transactionService;
    private final CategoryService categoryService;

    public TransactionController(TransactionService transactionService, CategoryService categoryService) {
        this.transactionService = transactionService;
        this.categoryService = categoryService;
    }

    @PostMapping("")
    public String displayCategoryForm(@ModelAttribute @Valid TransactionDto transactionDto,
                                      @PathVariable Long categoryId, BindingResult bindingResult,
                                      RedirectAttributes attr,
                                      Model model, @PathVariable Long budgetId){
        if (!bindingResult.hasErrors()){
            Category transactionCategory = categoryService.findCategoryById(categoryId);
            Set<Transaction> categoryTransactions = transactionService.addTransaction(transactionDto, transactionCategory);
            model.addAttribute("categoryTransactions", categoryTransactions);
        } else {
            attr.addFlashAttribute("org.springframework.validation.BindingResult.transactionDto", bindingResult);
            attr.addFlashAttribute("transactionDto", transactionDto);
        }
        return "redirect:/auth/budgets/{budgetId}/categories/{categoryId}";
    }

}
