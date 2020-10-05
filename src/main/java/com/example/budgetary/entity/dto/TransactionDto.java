package com.example.budgetary.entity.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TransactionDto {


    @Pattern(regexp = "[A-Za-z0-9-_/ .]{1,20}", message = "* Please name your transaction (1-20 characters)")
    private String title;

    private String type;

    private BigDecimal sum;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

}
