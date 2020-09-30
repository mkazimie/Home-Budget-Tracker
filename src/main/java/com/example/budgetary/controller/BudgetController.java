package com.example.budgetary.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/auth")
public class BudgetController {

    @GetMapping("/budgets")
    public String displayBudgets(){
        return "budgets";
    }

    @GetMapping("/dashboard")
    public String displayDashboard(){
        return "dashboard";
    }


}
