package com.example.budgetary.repository;

import com.example.budgetary.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    @Query("SELECT c FROM Category c LEFT JOIN FETCH c.budget b WHERE c.name = ?1 AND b.id = ?2")
    Category findByName(String name, Long budgetId);

}