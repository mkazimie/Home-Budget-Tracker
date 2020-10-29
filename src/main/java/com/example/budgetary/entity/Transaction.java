package com.example.budgetary.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;

@Data
@Entity
@Table(name = "transactions")
public class Transaction implements Comparable<Transaction> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    @Pattern(regexp = "[A-Za-z0-9-_/ .]{1,30}", message = "* Please name your transaction (1-30 alphanumeric " +
            "characters)")
    private String title;

    private String type;

    private BigDecimal sum;

    @ManyToOne
    private Category category;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime dateTimeAdded;

    @PrePersist
    public void prePersist() {
        dateTimeAdded = LocalDateTime.now();
    }

    @Override
    public int compareTo(Transaction transaction) {
        int compareTo = 0;
        if (this.getDateTimeAdded() != null && transaction.getDateTimeAdded() != null) {
            compareTo = this.getDateTimeAdded().compareTo(transaction.getDateTimeAdded());
        }
        return compareTo * -1;
    }
}