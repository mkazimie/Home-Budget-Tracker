package com.example.budgetary.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

@Getter
@Setter
@Entity
@Table(name = "budgets")
public class Budget implements Comparable<Budget> {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    @NotNull
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate endDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime dateTimeAdded;

    @PrePersist
    public void prePersist() {
        dateTimeAdded = LocalDateTime.now();
    }

    @ManyToMany
    @JoinTable(name = "budgets_users", joinColumns = @JoinColumn(name = "budget_id"), inverseJoinColumns =
    @JoinColumn(name = "user_id"))
    private Set<User> users = new HashSet<>();

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "budget")
    @OrderBy
    private SortedSet<Category> categories = new TreeSet<>();

    @Override
    public int compareTo(Budget budget) {
        int compareTo=0;
        if(this.getId() != null && budget.getId()!= null){
            compareTo = this.getId().compareTo(budget.getId());
        }
        return compareTo * (-1);
    }
}