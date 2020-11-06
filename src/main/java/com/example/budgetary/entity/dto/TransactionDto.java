package com.example.budgetary.entity.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class TransactionDto {

    @Pattern(regexp = "[A-Za-z0-9-_/ .]{1,30}", message = "* Please name your transaction (1-30 alphanumeric " +
            "characters)")
    @NotBlank
    private String title;

    @NotBlank
    private String type;

    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer=6, fraction=2)
    @NotNull
    private BigDecimal sum;

    @NotBlank
    private String categoryName;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @PastOrPresent
    @NotNull
    private LocalDate date;

    private LocalDateTime added;

    private Long budgetId;
}