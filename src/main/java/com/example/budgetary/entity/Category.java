package com.example.budgetary.entity;

import lombok.*;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

@Getter
@Setter
@ToString(exclude = "transactions")
@Entity
@Table(name = "categories")
public class Category implements Comparable<Category> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer=6, fraction=2)
    @NotNull
    private BigDecimal categoryAllowance;

    @ManyToOne
    private Budget budget;

    @OneToMany(mappedBy = "category")
    @OrderBy("dateTimeAdded DESC")
    private SortedSet<Transaction> transactions = new TreeSet<>();

    @Override
    public int compareTo(Category category) {
        int compareTo= 0;
        if (this.getId() != null && category.getId() != null){
            compareTo = this.getId().compareTo(category.getId());
        }
        return compareTo;
    }
}