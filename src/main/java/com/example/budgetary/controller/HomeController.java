package com.example.budgetary.controller;

import com.example.budgetary.entity.dto.UserDto;
import com.example.budgetary.exception.RecordAlreadyExistsException;
import com.example.budgetary.security.CurrentUser;
import com.example.budgetary.service.UserService;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
public class HomeController {

    private final UserService userService;

    public HomeController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String displayLandingPage(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (currentUser != null){
            model.addAttribute("currentUser", currentUser.getUser());
        }
        return "landing-page";
    }

    @GetMapping("/login")
    public String login(@AuthenticationPrincipal CurrentUser currentUser) {
        if (currentUser != null) {
            return "redirect:/auth/budgets";
        }
        return "login";
    }

    @GetMapping("/login/error")
    public String loginFailure(HttpServletRequest request, RedirectAttributes attr) {
        HttpSession session = request.getSession(false);
        String errorMessage = null;
        if (session != null) {
            AuthenticationException exception = (AuthenticationException) session.getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
            if (exception != null) {
                errorMessage = exception.getMessage();
            }
        }
        attr.addFlashAttribute("error", errorMessage);
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String register(@AuthenticationPrincipal CurrentUser currentUser, Model model) {
        if (currentUser != null){
            return "redirect:/logout";
        }
        UserDto userDto = new UserDto();
        model.addAttribute(userDto);
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute @Valid UserDto userDto, BindingResult result, Model model) {
        if (!result.hasErrors()) {
            String password = userDto.getPassword();
            String matchingPassword = userDto.getMatchingPassword();
            if (!matchingPassword.equals(password)) {
                model.addAttribute("error", "Passwords must match");
                return "register";
            }
            try {
                userService.registerUser(userDto);
            } catch (RecordAlreadyExistsException e) {
                model.addAttribute("error", "Username already exists");
                return "register";
            }
            return "redirect:/login";
        }
        return "register";
    }
}