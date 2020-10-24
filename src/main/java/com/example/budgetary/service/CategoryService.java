package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.CategoryRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;
import java.util.SortedSet;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final BudgetService budgetService;
    private final TransactionService transactionService;

    public CategoryService(CategoryRepository categoryRepository, BudgetService budgetService, TransactionService transactionService) {
        this.categoryRepository = categoryRepository;
        this.budgetService = budgetService;
        this.transactionService = transactionService;
    }

    public Category findCategoryById(Long id) {
        Optional<Category> category = categoryRepository.findById(id);
        return category.orElseThrow(() -> new NoRecordFoundException("No record found in our DB"));
    }

    public Category findCategoryByName(String name, Long budgetId) {
        return categoryRepository.findByName(name, budgetId);
    }

    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }

    public SortedSet<Category> addNewCategory(CategoryDto categoryDto, Budget budget, User user) {
        Category category = new Category();
        String categoryDtoName = categoryDto.getSelectedName();
        if (categoryDtoName.equals("customized")) {
            category.setName(categoryDto.getOwnName());
        } else {
            category.setName(categoryDtoName);
        }
        category.setCategoryBudget(categoryDto.getCategoryMoney());
        category.setMoneyLeft(categoryDto.getCategoryMoney());
        category.setBudget(budget);
        saveCategory(category);
        BigDecimal budgetMoney = budget.getBudgetMoney();
        BigDecimal moneyLeftInBudget = budget.getMoneyLeft();
        budget.setBudgetMoney(budgetMoney.add(category.getCategoryBudget()));
        budget.setMoneyLeft(moneyLeftInBudget.add(category.getMoneyLeft()));
        Transaction transaction = createTransaction(budget, user);
        transaction.setType("Deposit");
        transaction.setTitle("New Category " + category.getName());
        transaction.setSum(category.getCategoryBudget());
        transactionService.saveTransaction(transaction);
        SortedSet<Category> budgetCategories = budget.getCategories();
        budgetService.saveBudget(budget);
        return budgetCategories;
    }

    public void removeCategory(Long id, User user) {
        Category categoryById = findCategoryById(id);
        BigDecimal categoryMoneyLeft = categoryById.getMoneyLeft();
        Budget budget = categoryById.getBudget();

        SortedSet<Transaction> categoryTransactions = categoryById.getTransactions();
        if (categoryTransactions != null) {
            categoryTransactions.forEach(transaction -> transaction.setCategory(null));
        }
        budget.setBudgetMoney(budget.getBudgetMoney().subtract(categoryById.getCategoryBudget()));
        budget.setMoneyLeft(budget.getMoneyLeft().subtract(categoryMoneyLeft));
        Transaction transaction = createTransaction(budget, user);
        transaction.setTitle("Remove Category " + categoryById.getName());
        transaction.setType("Withdrawal");
        transaction.setSum(categoryMoneyLeft);
        transactionService.saveTransaction(transaction);
        categoryById.setBudget(null);
        categoryRepository.delete(categoryById);
    }

    private Transaction createTransaction(Budget budget, User user) {
        Transaction transaction = new Transaction();
        transaction.setBudget(budget);
        transaction.setCurrentBalance(budget.getMoneyLeft());
        transaction.setDate(LocalDate.now());
        transaction.setUser(user);
        return transaction;
    }
}