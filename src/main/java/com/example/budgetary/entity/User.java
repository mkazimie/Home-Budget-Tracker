package com.example.budgetary.entity;


import lombok.*;

import javax.persistence.*;
import java.util.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String userName;

    private String password;

    private String email;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "user")
    private Set<Transaction> transactions = new TreeSet<>();

    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "users")
    private Set<Budget> budgets = new TreeSet<>();

}
