package com.example.budgetary.entity.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Pattern;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryDto {

    @Pattern(regexp = "[A-Za-z0-9]{1,20}", message = "Please name your category (1-20 alphanumerical characters)")
    private String name;

    private BigDecimal categoryMoney;
}
