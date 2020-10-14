$(document).ready(function () {
    $('#dataTable').DataTable({
        "order": [[0, "desc"]]
    });
    $('.dataTables_length').addClass('bs-select');
});


// Edit modal
$('#editModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let categoryName = button.data('name');
    let categoryBudget = button.data('budget');
    let modal = $(this)
    modal.find('#nameInput').val(categoryName);
    modal.find('#budgetInput').val(categoryBudget);
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

// Delete from Transactions Modal
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

