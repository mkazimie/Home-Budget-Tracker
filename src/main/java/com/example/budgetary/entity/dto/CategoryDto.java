package com.example.budgetary.entity.dto;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Getter
@Setter
public class CategoryDto {

    @NotBlank
    private String selectedName;

    private String ownName;

    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer=6, fraction=2)
    @NotNull
    private BigDecimal categoryAllowance;

    private Long budgetId;
}