<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!--MODAL FORM to update BUDGET -->
<div id="editBudgetModal" class="modal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary d-table justify-content-between">
                <div class="d-table-cell align-middle">
                    <h5 class="modal-title text-white font-weight-bolder text-center">
                        Edit Budget</h5>
                </div>
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="addAlert"></div>
                <form:form id="editBudgetForm" method="post"
                           action=""
                           modelAttribute="budget">
                <div class="form-group">
                    <div class="errorMessage alert alert-danger d-none" role="alert"></div>
                    <div class="row">
                        <label class="col-sm-2 col-form-label text-primary">
                            Name:</label>
                        <div class="col-sm-10">
                            <form:input path="name" type="text" id="nameInput"
                                        class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        Start Date:</label>
                    <div class="col-sm-10">
                        <form:input id="startInput" path="startDate" type="date" class="form-control"
                                    placeholder="yyyy-MM-dd"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="errorMessage alert alert-danger d-none" role="alert"></div>
                    <div class="row">
                        <label class="col-sm-2 col-form-label text-primary">
                            End Date:</label>
                        <div class="col-sm-10">
                            <form:input id="endInput" path="endDate" type="date"
                                        class="form-control"
                                        placeholder="yyyy-MM-dd"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <form:hidden path="budgetMoney" id="budgetMoney"/>
                <form:hidden path="moneyLeft" id="moneyLeft"/>
                <form:hidden path="categories" id="categories"/>
                <form:hidden path="transactions" id="transactions"/>
                <form:hidden path="users" id="users"/>
                <button id="submitBtn" type="submit" class="btn btn-primary"> Save
                    changes
                </button>
                <button id="closeModalBtn" type="button" class="btn btn-secondary"
                        data-dismiss="modal"> Close
                </button>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>