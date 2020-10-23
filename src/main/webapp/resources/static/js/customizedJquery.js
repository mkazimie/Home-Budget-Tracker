$(document).ready(function () {
    $('#dataTable').DataTable({
        "order": [[0, "desc"]]
    });
    $('.dataTables_length').addClass('bs-select');
});


// Edit Category Modal
let $editCategoryModal = $('#editModal');

$editCategoryModal.on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let categoryName = button.data('name');
    let categoryBudget = button.data('catbudget');
    let budgetId = button.data('budget');
    let catId = button.data('id');
    let modal = $(this)
    modal.find('#catName').val(categoryName);
    modal.find('#catBudget').val(categoryBudget);

    $('#submitCatBtn').click(function (event) {
        event.preventDefault();
        let $catName = $("#catName");
        let $catBudget = $("#catBudget");
        let $catMoneyLeft = $("#catMoneyLeft");
        let $budget = $("#budget");
        let $catTransactions = $("#catTransactions");
        let $dateAdded = $("#added");


        //
        let catNameVal = $catName.val();
        let catBudgetVal = $catBudget.val();
        let catMoneyLeftVal = $catMoneyLeft.val();
        let budgetVal = $budget.val();
        let catTransactionsVal = $catTransactions.val();
        let dateAddedVal = $dateAdded.val();

        $.ajax({

            type: "PUT",
            url: "/auth/budgets/" + budgetId + "/categories/" + catId,
            data: {
                "name": catNameVal,
                "categoryBudget": catBudgetVal,
                "budget": budgetVal,
                "moneyLeft": catMoneyLeftVal,
                "transactions": catTransactionsVal,
                "dateAdded": dateAddedVal,
            },
            success: function (response) {

                if (response.status === 'FAIL') {
                    showCatForm(response.errorMessageList);
                } else {
                    //everything is O.K. budget updated successfully.
                    $editCategoryModal.modal('hide');
                    window.location.reload();
                }
            },
            error: function (ex) {
                console.log(ex);
            }

        });

        function showCatForm(errorVal) {
            //show error messages that comming from backend and change border to red.
            for (let i = 0; i < errorVal.length; i++) {
                if (errorVal[i].fieldName === 'name') {
                    $catName.val('');
                    $catName.css("border", " 1px solid red");
                    $catName.siblings(".errorMessage").text(errorVal[i].message).removeClass("d-none");
                } else if (errorVal[i].fieldName === 'categoryBudget') {
                    $catBudget.val('');
                    $catBudget.css("border", " 1px solid red");
                    $catBudget.siblings(".errorMessage").text(errorVal[i].message).removeClass("d-none");

                }
            }
        }
    });
});

// clear all after modal closed and return it as default.
$editCategoryModal.on('hide.bs.modal', function () {
    $('#catName').css("border", "1px solid lightgrey");
    $('#catBudget').css("border", "1px solid lightgrey");
    $('.errorMessage').addClass("d-none");
});


// // Edit Transaction Modal
$('#editTransactionModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let budgetId = button.data('budget');
    let categoryId = button.data('category');
    let transactionTitle = button.data('title');
    let transactionId = button.data('id');
    let transactionSum = button.data('sum');
    let transactionDate = button.data('date');
    let modal = $(this)
    modal.find('form').attr("action", "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/transactions/" +
        transactionId + "/update");
    modal.find('#transactionTitle').val(transactionTitle);
    modal.find('#transactionSum').val(transactionSum);
    modal.find('#transactionDate').val(transactionDate);
    modal.find('#transactionId').val(transactionId);
})

// // Edit Budget Modal
let editBudgetModal = $('#editBudgetModal');
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

    $('#submitBtn').click(function (event) {
        event.preventDefault();
        let nameInput = $("#nameInput");
        let startInput = $("#startInput");
        let endInput = $("#endInput");
        let categoriesInput = $("#categories");
        let transactionsInput = $("#transactions");
        let usersInput = $("#users");
        let budgetMoneyInput = $("#budgetMoney");
        let moneyLeftInput = $("#moneyLeft");


        let nameValue = nameInput.val();
        let startValue = startInput.val();
        let endValue = endInput.val();
        let categoriesValue = categoriesInput.val();
        let transactionsValue = transactionsInput.val();
        let usersValue = usersInput.val();
        let budgetMoneyValue = budgetMoneyInput.val();
        let moneyLeftValue = moneyLeftInput.val();

        $.ajax({

            type: "PUT",
            url: "/auth/budgets/" + budgetId,
            data: {
                "name": nameValue,
                "startDate": startValue,
                "endDate": endValue,
                "transactions": transactionsValue,
                "categories": categoriesValue,
                "users": usersValue,
                "budgetMoney": budgetMoneyValue,
                "moneyLeft": moneyLeftValue,
            },
            success: function (response) {

                if (response.status === 'FAIL') {
                    showFormError(response.errorMessageList);
                } else {
                    //everything is O.K. budget updated successfully.
                    $('#editBudgetModal').modal('hide');
                    window.location.reload();
                }
            },
            error: function (ex) {
                console.log(ex);
            }


        });


        function showFormError(errorVal) {
            //show error messages that comming from backend and change border to red.
            for (let i = 0; i < errorVal.length; i++) {
                if (errorVal[i].fieldName === 'name') {
                    nameInput.val('');
                    nameInput.css("border", " 1px solid red");
                    nameInput.css("border", " 1px solid red");
                    nameInput.siblings(".errorMessage").text(errorVal[i].message).removeClass("d-none");
                } else if (errorVal[i].fieldName === 'startDate') {
                    startInput.val('');
                    startInput.css("border", " 1px solid red");
                } else if (errorVal[i].fieldName === 'endDate') {
                    endInput.val('');
                    endInput.css("border", " 1px solid red");
                    endInput.siblings(".errorMessage").text(errorVal[i].message).removeClass("d-none");
                }
            }
        }
    });

});
// clear all after modal closed and return it as default.
editBudgetModal.on('hide.bs.modal', function () {
    $('#nameInput').css("border", "1px solid lightgrey");
    $('#startInput').css("border", "1px solid lightgrey");
    $('#endInput').css("border", "1px solid lightgrey");
    $('.errorMessage').addClass("d-none");
})
// }


//Delete Category Modal
$('#deleteCategoryModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let categoryName = button.data('name') // Extract info from data-* attributes
    let categoryId = button.data('id') // Extract info from data-* attributes
    let budgetId = button.data('budget') // Extract info from data-* attributes
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/delete");
    modal.find('.modal-body strong').text(" " + categoryName);
})

// Delete Transaction Modal
$('#deleteTransactionModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let transactionTitle = button.data('title') // Extract info from data-* attributes
    let transactionId = button.data('id') // Extract info from data-* attributes
    let categoryId = button.data('category') // Extract info from data-* attributes
    let budgetId = button.data('budget') // Extract info from data-* attributes
    let modal = $(this)
    if (categoryId != null) {
        modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/categories/" + categoryId +
            "/transactions/" + transactionId);
    } else {
        modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/transactions/" + transactionId);
    }
    modal.find('.modal-body strong').text(" " + transactionTitle);
})


// Delete Budget Modal
$('#deleteBudgetModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let budgetName = button.data('name') // Extract info from data-* attributes
    let budgetId = button.data('id') // Extract info from data-* attributes
    let categoriesCount = button.data('categories') // Extract info from data-* attributes
    let transactionsCount = button.data('transactions') // Extract info from data-* attributes
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/delete");
    modal.find('.modal-body strong').text(" " + budgetName);
    modal.find('#catCount').text(" " + categoriesCount + " ")
    modal.find('#transCount').text(" " + transactionsCount + " ")

})


// Add Own Input or Select From List while adding new category
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


$("#budgetForm").change(function () {
    if ($("#startDate") > $("#endDate")) {
        alert("Invalid Date Range")
    }

});

$(document).ready(function () {
    let $errorMsg = $(".errorMsg");
    if ($errorMsg.text() !== '') {
        $errorMsg.removeClass("d-none");
    }
});



