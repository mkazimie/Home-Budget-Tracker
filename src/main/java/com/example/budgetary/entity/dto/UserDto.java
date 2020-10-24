package com.example.budgetary.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import javax.validation.constraints.Pattern;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    @Pattern(regexp = "^[a-zA-Z0-9_.-].{5,15}$", message = "* Username must be 5-15 characters long")
    private String username;


    @Pattern(regexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,20}$",
            message = "* Password:" +
                     "\n\u2022 must be 8-20 characters long" +
                    "\n\u2022 must include at least one uppercase letter, one digit and one special character")
    private String password;

    private String matchingPassword;

}