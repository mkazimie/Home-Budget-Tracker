package com.example.budgetary.entity.dto;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
public class TransactionDto {


    @Pattern(regexp = "[A-Za-z0-9-_/ .]{1,30}", message = "* Please name your transaction (1-30 alphanumeric " +
            "characters)")
    @NotBlank
    private String title;

    @NotBlank
    private String type;

    private BigDecimal sum;

    private List<String> categoryNames;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @PastOrPresent
    private LocalDate date;

}