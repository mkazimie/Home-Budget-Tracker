package com.example.budgetary.controller;

import com.example.budgetary.entity.User;
import com.example.budgetary.service.UserService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

    private final UserService userService;

    public HomeController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String hello() {
        return "index";
    }

    @GetMapping(value = "/create-user", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String createUser(){
        User user = new User();
        user.setUsername("user");
        user.setPassword("user");
        userService.saveUser(user);
        return user.toString();
    }

    @GetMapping("/login")
    public String getLogin(Model model){
        User user = new User();
        model.addAttribute(user);
        return "login";
    }



}
