package com.example.budgetary.controller;

import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.dto.TransactionDto;
import com.example.budgetary.service.TransactionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/auth/users/{userId}")
public class UserController {

    private final TransactionService transactionService;

    public UserController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @GetMapping("/transactions")
    public String displayTransactionsByUser(@PathVariable long userId, Model model){
        List<Transaction> allTransactionsByUser = transactionService.findAllByBudgetUserId(userId);
        model.addAttribute("allTransactionsByUser", allTransactionsByUser);
        if (!model.containsAttribute("transactionDto")) {
            model.addAttribute("transactionDto", new TransactionDto());
        }
        return "user-transactions";
    }
}
