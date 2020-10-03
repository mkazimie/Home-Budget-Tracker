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
public class Category implements Comparable<Category> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private BigDecimal categoryMoney;


    @ManyToOne
    private Budget budget;

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "category")
    private Set<Transaction> transactions = new HashSet<>();


    @Override
    public int compareTo(Category category) {
        int compareTo= 0;
        if (this.getId() != null && category.getId() != null){
            compareTo = this.getId().compareTo(category.getId());
        }
        return compareTo;
    }
}
