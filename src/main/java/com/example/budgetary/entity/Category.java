package com.example.budgetary.entity;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "categories")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private BigDecimal moneyLeft;

    @ManyToOne
    private Budget budget;

    private LocalDate startDate;

    private LocalDate endDate;

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "category")
    private Set<Transaction> transactions = new HashSet<>();


}
