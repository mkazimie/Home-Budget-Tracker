package com.example.budgetary.entity;

import lombok.*;
import org.springframework.stereotype.Service;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "transactions")
@Entity
@Table(name = "categories")
public class Category implements Comparable<Category> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private BigDecimal categoryBudget;

    private BigDecimal moneyLeft;

    @ManyToOne
    private Budget budget;

    @OneToMany(cascade = CascadeType.PERSIST, mappedBy = "category")
    @OrderBy("dateTimeAdded DESC ")
    private SortedSet<Transaction> transactions = new TreeSet<>();

    private LocalDateTime dateAdded;

    private LocalDateTime dateUpdated;

    @PrePersist
    public void prePersist(){
        dateAdded = LocalDateTime.now();
    }

    @PreUpdate
    public void preUpdate(){
        dateUpdated = LocalDateTime.now();
    }

    @Override
    public int compareTo(Category category) {
        int compareTo= 0;
        if (this.getId() != null && category.getId() != null){
            compareTo = this.getId().compareTo(category.getId());
        }
        return compareTo;
    }
}
