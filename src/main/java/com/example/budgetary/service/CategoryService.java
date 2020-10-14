package com.example.budgetary.service;

import com.example.budgetary.entity.Budget;
import com.example.budgetary.entity.Category;
import com.example.budgetary.entity.Transaction;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.CategoryDto;
import com.example.budgetary.exception.NoRecordFoundException;
import com.example.budgetary.repository.CategoryRepository;
import com.example.budgetary.security.CurrentUser;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Optional;
import java.util.SortedSet;
import java.util.TreeSet;

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

    public Category findByName(String name, Long budgetId) {
        return categoryRepository.findByName(name, budgetId);
    }

    public void saveCategory(Category category) {
        categoryRepository.save(category);
    }

    public void deleteCategory(Long id){
        categoryRepository.delete(findCategoryById(id));
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
        transaction.setTitle("Add " + category.getName() + " budget");
        transaction.setSum(category.getCategoryBudget());
        transactionService.saveTransaction(transaction);
        SortedSet<Category> budgetCategories = budget.getCategories();
        budgetService.saveBudget(budget);
        return budgetCategories;
    }

    public void updateCategory(Category updatedCategory, Category originalCategory, Budget budget, User user) {
        BigDecimal updatedCatBudget = updatedCategory.getCategoryBudget();
        BigDecimal originalCatBudget = originalCategory.getCategoryBudget();
        BigDecimal catBudgetDifference = updatedCatBudget.subtract(originalCatBudget);

        originalCategory.setName(updatedCategory.getName());
        originalCategory.setCategoryBudget(updatedCatBudget);
        originalCategory.setMoneyLeft(originalCategory.getMoneyLeft().add(catBudgetDifference));
        saveCategory(originalCategory);
        budget.setMoneyLeft(budget.getMoneyLeft().add(catBudgetDifference));
        budget.setBudgetMoney(budget.getBudgetMoney().add(catBudgetDifference));
        Transaction transaction = createTransaction(budget, user);
        transaction.setTitle("Modify " + originalCategory.getName() + " budget");
        transaction.setSum(catBudgetDifference);
        if (catBudgetDifference.compareTo(BigDecimal.ZERO) > 0) {
            transaction.setType("Deposit");
        } else {
            transaction.setType("Withdrawal");
        }
        transactionService.saveTransaction(transaction);
        budgetService.saveBudget(budget);
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
        transaction.setTitle("Remove category " + categoryById.getName());
        transaction.setType("Withdrawal");
        transaction.setSum(categoryMoneyLeft);
        transactionService.saveTransaction(transaction);
        categoryById.setBudget(null);
        deleteCategory(categoryById.getId());
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
