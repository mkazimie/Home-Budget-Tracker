package com.example.budgetary.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "transactions")
public class Transaction implements Comparable<Transaction> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String type;

    private BigDecimal sum;

    @ManyToOne
    private Category category;

    @ManyToOne
    private Budget budget;

    private BigDecimal currentBalance;

    @ManyToOne
    private User user;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime dateTimeAdded;

    @PrePersist
    public void prePersist() {
        dateTimeAdded = LocalDateTime.now();
    }

//    private String formattedDateTime;

    @Override
    public int compareTo(Transaction transaction) {
        int compareTo= 0;
        if (this.getId() != null && transaction.getId() != null){
            compareTo = this.getId().compareTo(transaction.getId());
        }
        return compareTo;
    }

//    public void setFormattedDateTime(LocalDateTime dateAdded) {
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
//        this.formattedDateTime = dateAdded.format(formatter);
//    }
}
