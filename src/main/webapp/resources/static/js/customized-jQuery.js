// Order Tables By First Column Desc
$(document).ready(function () {
    $('#dataTable').DataTable({
        "order": [[0, "desc"]]
    });
    $('.dataTables_length').addClass('bs-select');
});

// Toggle Forms in Budget Dashboard
$('.toggle-form').click(function () {
    $(this).children().toggleClass('fa-plus, fa-times');
    $(this).toggleClass('btn-outline-success, btn-outline-dark');
})

// Add New Transaction
let transactionForm = $('#transactionForm');
let category = $('#selectTransactionCategory');
let uri = window.location.href;
if (uri.indexOf('categories') !== -1) {
    let uriSplit = uri.split("/");
    categoryId = uriSplit.pop();
    category.val(categoryId);
    category.attr('disabled', 'disabled');
}
transactionForm.submit(function (event) {
    event.preventDefault();
    let categoryId = "";
    let title = $('#title');
    let sum = $('#sum');
    let date = $('#date');
    let budgetId = $('#budgetId').val();
    categoryId = category.val();
    let type = $('#type');

    $.ajax({

        type: "POST",
        url: "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/transactions",
        data: {
            "title": title.val(),
            "sum": sum.val(),
            "date": date.val(),
            "type": type.val(),
            "categoryName": categoryId,
        },
        success: function (response) {

            if (response.status === 'FAIL') {
                let errorMessageList = response.errorMessageList;
                showErrorsForm(errorMessageList, transactionForm);
            } else {
                window.location.reload();
            }
        },
        error: function (ex) {
            console.log(ex);
        }
    });
});

// Add New Category
let categoryForm = $('#categoryForm');

categoryForm.submit(function (event) {
    event.preventDefault();
    let selectedName = $('#selectCat');
    let ownName = $('#ownName');
    let categoryAllowance = $('#categoryAllowance');
    let budgetId = $('#budgetId').val();

    $.ajax({

        type: "POST",
        url: "/auth/budgets/" + budgetId + "/categories/",
        data: {
            "selectedName": selectedName.val(),
            "ownName": ownName.val(),
            "categoryAllowance": categoryAllowance.val(),
        },
        success: function (response) {

            if (response.status === 'FAIL') {
                let errorMessageList = response.errorMessageList;
                showErrorsForm(errorMessageList, categoryForm);

            } else {
                window.location.reload();
            }
        },
        error: function (ex) {
            console.log(ex);
        }
    });
});

// Error Display For Ajax Response
function showErrorsForm(errorMessageList, form) {
    let allFormInputs = form.find(".form-control");
    allFormInputs.each(function () {
        for (let i = 0; i < errorMessageList.length; i++) {
            errorMessageList[i].fieldName === "generalError" && form.find(".generalErrorMessage").text(errorMessageList[i].message).removeClass("d-none");
            ($(this).attr("name") === errorMessageList[i].fieldName) && $(this).closest(".form-group").children(".errorMessage").text(errorMessageList[i].message).removeClass("d-none");
        }
    });
}

// Edit Category Form Modal
let $editCategoryModal = $('#editModal');
let editCategoryForm = $('#editCategoryForm');
$editCategoryModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let categoryName = button.data('name');
    let categoryAllowance = button.data('allowance');
    let budgetId = button.data('budget');
    let catId = button.data('id');
    let modal = $(this)
    modal.find('#catName').val(categoryName);
    modal.find('#categoryAllowance').val(categoryAllowance);

    editCategoryForm.submit(function (event) {
        event.preventDefault();
        let catName = $("#catName");
        let categoryAllowance = $("#categoryAllowance");
        let budget = $("#budget");
        let catTransactions = $("#catTransactions");

        $.ajax({

            type: "PUT",
            url: "/auth/budgets/" + budgetId + "/categories/" + catId,
            data: {
                "name": catName.val(),
                "categoryAllowance": categoryAllowance.val(),
                "budget": budget.val(),
                "transactions": catTransactions.val(),
            },
            success: function (response) {

                if (response.status === 'FAIL') {
                    showErrorsForm(response.errorMessageList, editCategoryForm);
                } else {
                    $editCategoryModal.modal('hide');
                    window.location.reload();
                }
            },
            error: function (ex) {
                console.log(ex);
            }
        });
    });
});

// Edit Transaction Form Modal
let $editTransactionModal = $('#editTransactionModal');
let $editTransactionForm = $('#editTransactionForm');
$editTransactionModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let budgetId = button.data('budget');
    let categoryId = button.data('category');
    let transactionId = button.data('id');
    let transactionTitle = button.data('title');
    let transactionSum = button.data('sum');
    let transactionType = button.data('type');
    let transactionDate = button.data('date');
    let added = button.data('added');
    let modal = $(this);

    modal.find('#transactionTitle').val(transactionTitle);
    modal.find('#transactionSum').val(transactionSum);
    modal.find('#transactionDate').val(transactionDate);
    modal.find('#added').val(added);

    $editTransactionForm.submit(function (event) {
        event.preventDefault();
        let transactionTitle = $("#transactionTitle");
        let transactionSum = $("#transactionSum");
        let transactionDate = $("#transactionDate");

        $.ajax({
            type: "PUT",
            url: "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/transactions/" + transactionId,
            data: {
                "title": transactionTitle.val(),
                "sum": transactionSum.val(),
                "date": transactionDate.val(),
                "category": categoryId,
                "type": transactionType,
            },
            success: function (response) {

                if (response.status === 'FAIL') {
                    showErrorsForm(response.errorMessageList, editCategoryForm);
                } else {
                    $editCategoryModal.modal('hide');
                    window.location.reload();
                }
            },
            error: function (ex) {
                console.log(ex);
            }
        });
    });
})

// Edit Budget Form Modal
let editBudgetModal = $('#editBudgetModal');
let editBudgetForm = $('#editBudgetForm');
editBudgetModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let budgetName = button.data('name');
    let budgetId = button.data('id');
    let start = button.data('start');
    let end = button.data('end');
    let modal = $(this)
    modal.find('#nameInput').val(budgetName);
    modal.find('#startInput').val(start);
    modal.find('#endInput').val(end);

    editBudgetForm.submit(function (event) {
        event.preventDefault();
        let nameInput = $("#nameInput");
        let startInput = $("#startInput");
        let endInput = $("#endInput");
        let categoriesInput = $("#categories");
        let usersInput = $("#users");

        $.ajax({

            type: "PUT",
            url: "/auth/budgets/" + budgetId,
            data: {
                "name": nameInput.val(),
                "startDate": startInput.val(),
                "endDate": endInput.val(),
                "categories": categoriesInput.val(),
                "users": usersInput.val(),
            },
            success: function (response) {
                if (response.status === 'FAIL') {
                    showErrorsForm(response.errorMessageList, editBudgetForm);
                } else {
                    $('#editBudgetModal').modal('hide');
                    window.location.reload();
                }
            },
            error: function (ex) {
                console.log(ex);
            }
        });
    });
});

//Delete Category Modal
$('#deleteCategoryModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let categoryName = button.data('name')
    let categoryId = button.data('id')
    let budgetId = button.data('budget')
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/delete");
    modal.find('.modal-body strong').text(" " + categoryName);
})

// Delete Transaction Modal
let $deleteTransactionModal = $('#deleteTransactionModal');
$deleteTransactionModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let transactionTitle = button.data('title')
    let transactionId = button.data('id')
    let categoryId = button.data('category')
    let budgetId = button.data('budget')
    let modal = $(this)
    modal.find('.modal-body strong').text(" " + transactionTitle);

    $('#deleteTransactionBtn').click(function (event) {
        event.preventDefault();

        $.ajax({
            type: "DELETE",
            url: "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/transactions/" + transactionId,
            success: function (response) {
                if (response.status === 'SUCCESS') {
                    $deleteTransactionModal.modal('hide');
                    button.closest('tr').remove();
                    $('.confirmSuccess').removeClass('d-none').text("Transaction " + transactionId + " has been" +
                        " removed")
                }
            },
            error: function (ex) {
                console.log(ex);
            }
        })
    })
});

// Delete Budget Modal
let $deleteBudgetModal = $('#deleteBudgetModal');
$deleteBudgetModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let budgetName = button.data('name')
    let budgetId = button.data('id')
    let categoriesCount = button.data('categories')
    let modal = $(this);
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/delete");

    modal.find('.modal-body strong').text(" " + budgetName);
    modal.find('#catCount').text(" " + categoriesCount + (categoriesCount === 1 ? " category" : " categories"));
});

// Add Own Category Name or Select Category Name From List
$("#selectCat").change(function () {
    if ($(this).val() === "customized") {
        $("#selectInput").addClass("d-none");
        $("#ownInput").removeClass("d-none");
    }
});
$("#getCatList").change(function () {
    if ($("#getCatList").is(':checked')) {
        $("#selectInput").removeClass("d-none");
        $("#ownInput").addClass("d-none");
        this.checked = false;
        $("#selectCat option:selected").prop("selected", false);
    }
});

// Display Error Alert if message passed to model
$(document).ready(function () {
    let errorMsg = $(".errorMsg");
    errorMsg.text() !== '' && errorMsg.removeClass("d-none");
});