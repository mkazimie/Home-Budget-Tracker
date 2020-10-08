package com.example.budgetary.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

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

    @ManyToOne
    private User user;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;


    @Override
    public int compareTo(Transaction transaction) {
        int compareTo= 0;
        if (this.getId() != null && transaction.getId() != null){
            compareTo = this.getId().compareTo(transaction.getId());
        }
        return compareTo;
    }
}
