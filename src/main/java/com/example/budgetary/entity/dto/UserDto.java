package com.example.budgetary.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserDto {

    @NotBlank
    @Size(min = 5, max = 15)
    private String username;


    @NotEmpty
    @Size(min=5, max=15)
    private String password;
    private String matchingPassword;

}
