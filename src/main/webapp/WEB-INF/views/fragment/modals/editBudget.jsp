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
                <div class="errorMsg alert alert-danger d-none" role="alert">${error}</div>
            <form:form method="post"
                           action="/auth/budgets/${budget.id}"
                           modelAttribute="budget">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        Name:</label>
                    <div class="col-sm-10">
                        <form:input path="name" type="text" id="nameInput"
                                    name="budgetName"
                                    class="form-control"/>
                        <form:errors path="name" cssClass="errorMessage"/>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        Start Date:</label>
                    <div class="col-sm-10">
                        <form:input id="startInput" path="startDate" type="date" class="form-control"
                                    placeholder="yyyy-MM-dd"/>
                        <form:errors path="startDate" cssClass="errorMessage"/>

                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label text-primary">
                        End Date:</label>
                    <div class="col-sm-10">
                        <form:input id="endInput" path="endDate" type="date"
                                    class="form-control"
                                    placeholder="yyyy-MM-dd"/>
                        <form:errors path="endDate" cssClass="errorMessage"/>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <form:hidden path="id"/>
                <form:hidden path="budgetMoney"/>
                <form:hidden path="moneyLeft"/>
<%--                <form:hidden path="transactions"/>--%>
<%--                <form:hidden path="categories"/>--%>
                <button class="btn btn-primary" type="submit"> Save
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