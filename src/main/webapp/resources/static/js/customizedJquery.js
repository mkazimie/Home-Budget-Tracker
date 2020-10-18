$(document).ready(function () {
    $('#dataTable').DataTable({
        "order": [[0, "desc"]]
    });
    $('.dataTables_length').addClass('bs-select');
});


// Edit modal for Categories
$('#editModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let categoryName = button.data('name');
    let categoryBudget = button.data('budget');
    let modal = $(this)
    modal.find('#nameInput').val(categoryName);
    modal.find('#budgetInput').val(categoryBudget);
})

// // Edit modal for Transactions
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

//Delete From Categories Modal
$('#deleteFromAllModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let categoryName = button.data('name') // Extract info from data-* attributes
    let categoryId = button.data('id') // Extract info from data-* attributes
    let budgetId = button.data('budget') // Extract info from data-* attributes
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/categories/" + categoryId + "/delete");
    modal.find('.modal-body strong').text(" " + categoryName);
})

// Delete Transaction from Category Modal
$('#deleteTransactionModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let transactionTitle = button.data('title') // Extract info from data-* attributes
    let transactionId = button.data('id') // Extract info from data-* attributes
    let categoryId = button.data('category') // Extract info from data-* attributes
    let budgetId = button.data('budget') // Extract info from data-* attributes
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/categories/" + categoryId +
        "/transactions/" + transactionId);
    modal.find('.modal-body strong').text(" " + transactionTitle);
})

// Delete Transaction from Budget Modal
$('#deleteTransactionFromBudgetModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget) // Button that triggered the modal
    let transactionTitle = button.data('title') // Extract info from data-* attributes
    let transactionId = button.data('id') // Extract info from data-* attributes
    let budgetId = button.data('budget') // Extract info from data-* attributes
    let modal = $(this)
    modal.find('.modal-body a').attr("href", "/auth/budgets/" + budgetId + "/transactions/" + transactionId);
    modal.find('.modal-body strong').text(" " + transactionTitle);
})


// Delete Budget
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
    if ($errorMsg.text() !== ''){
        $errorMsg.removeClass("d-none");
    }
})

