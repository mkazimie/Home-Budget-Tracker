<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--MODAL FORM to update TRANSACTION -->
<div id="editTransactionModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary d-table justify-content-between">
                <div class="d-table-cell align-middle">
                    <h5 class="modal-title text-white font-weight-bolder text-center">
                        Edit Transaction </h5>
                </div>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="addAlert"></div>
                <form:form id="editTransactionForm"
                           method="post"
                           action=""
                           modelAttribute="transactionDto">
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label text-dark">
                            Title:</label>
                        <div class="col-sm-10">
                            <form:input path="title" type="text" id="transactionTitle"
                                        class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label text-dark">
                            Sum:</label>
                        <div class="col-sm-10">
                            <form:input path="sum" type="number" id="transactionSum"
                                        class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-2 col-form-label text-dark">
                            Date:</label>
                        <div class="col-sm-10">
                            <form:input type="date" id="transactionDate" path="date"
                                        class="form-control" min="${budget.startDate}"
                                        max="${budget.endDate}"/>
                        </div>
                    </div>
                    <div class="btn-wrapper text-center">
                        <button class="btn btn-primary" type="submit"> Save
                            changes
                        </button>
                        <button type="button" class="btn btn-secondary"
                                data-dismiss="modal"> Close
                        </button>
                    </div>
                </form:form>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</div>