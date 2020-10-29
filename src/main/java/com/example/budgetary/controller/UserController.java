package com.example.budgetary.controller;

import com.example.budgetary.entity.Transaction;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.TransactionService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/auth/users/{userId}")
public class UserController {

    private final TransactionService transactionService;

    public UserController(TransactionService transactionService) {
        this.transactionService = transactionService;
    }

    @GetMapping("/activity-log")
    public String fetchTransactionsByBudgetUser(@AuthenticationPrincipal CurrentUser currentUser, Model model){
        List<Transaction> allTransactionsByBudgetUser = transactionService.findAllByBudgetUser(currentUser.getUser());
        model.addAttribute("allTransactionsByBudgetUser", allTransactionsByBudgetUser);
        return "user-transactions";
    }
}
