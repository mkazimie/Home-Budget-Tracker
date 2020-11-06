package com.example.budgetary.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

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
    private LocalDateTime added;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime updated;

    @PrePersist
    public void prePersist() {
        added = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate() {
        updated = LocalDateTime.now();
    }

    @Override
    public int compareTo(Transaction transaction) {
        int compareTo = 0;
        if (this.getAdded() != null && transaction.getAdded() != null) {
            compareTo = this.getAdded().compareTo(transaction.getAdded());
        }
        return compareTo * -1;
    }
}