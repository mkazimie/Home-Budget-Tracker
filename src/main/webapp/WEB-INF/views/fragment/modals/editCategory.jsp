<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!--MODAL FORM to update CATEGORY -->
<div id="editModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary d-table justify-content-between">
                <div class="d-table-cell align-middle">
                    <h5 class="modal-title text-white font-weight-bolder text-center">
                        Edit category</h5>
                </div>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="addAlert"></div>
                <form:form method="post"
                           action=""
                           modelAttribute="category">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        Name:</label>
                    <div class="col-sm-10">
                        <div class="errorMessage alert alert-danger d-none text-center" role="alert"></div>
                        <form:input path="name" type="text" id="catName"
                                    class="form-control"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        Budget:</label>
                    <div class="col-sm-10">
                        <div class="errorMessage alert alert-danger d-none text-center" role="alert"></div>
                        <form:input type="number" id="catBudget" name="catBudget"
                                    class="form-control" path="categoryBudget"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <form:hidden path="id"/>
                <form:hidden path="moneyLeft" id="catMoneyLeft"/>
                <form:hidden path="budget" id="budget"/>
                <form:hidden path="transactions" id="catTransactions"/>
                <form:hidden path="dateAdded" id="added"/>
                <button id="submitCatBtn" type="submit" class="btn btn-primary" > Save
                    changes
                </button>
                <button type="button" class="btn btn-secondary"
                        data-dismiss="modal"> Close
                </button>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>