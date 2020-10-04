package com.example.budgetary.entity.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransactionDto {


    private String title;

    @NotNull
    private String type;

    private BigDecimal sum;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

}
