package com.example.budgetary.entity.dto;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;

@Getter
@Setter
public class CategoryDto {

    @NotBlank
    private String selectedName;

    private String ownName;

    private BigDecimal categoryMoney;
}