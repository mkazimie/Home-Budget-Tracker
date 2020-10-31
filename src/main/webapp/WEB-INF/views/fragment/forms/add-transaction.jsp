<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="card-body">
<div class="row no-gutters align-items-center justify-content-center">
<form:form id="transactionForm" method="post"
           action=""
           modelAttribute="transactionDto">
    <div class="form-group">
        <form:label path="categoryName" cssClass="text-dark"> Category </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <form:select path="categoryName" class="form-control" id="selectTransactionCategory">
            <form:option label="--Select--"
                         selected="selected" value=" "/>
            <form:options items="${budget.categories}" itemValue="id" itemLabel="name"/>
        </form:select>
    </div>
    <div class="form-group">
        <form:label path="title" cssClass="text-dark"> Title </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <form:input id="title" path="title" type="text" class="form-control form-control-user"
                    placeholder=""/>
    </div>
    <div class="form-group">
        <form:label path="sum" cssClass="text-dark"> Sum </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <div class="input-group">
            <form:input path="sum" type="number" min="1"
                        step=".01"
                        class="form-control form-control-user"
                        placeholder=""/>
            <div class="input-group-append">
                <span class="input-group-text">€</span>
            </div>
        </div>
    </div>
    <div class="form-group">
        <form:label path="date" cssClass="text-dark"> Date </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <form:input path="date" type="date" min="${budget.startDate}"
                    max="${budget.endDate}"
                    class="form-control form-control-user"
                    placeholder="yyyy-MM-dd"/>
    </div>
    </div>
    </div>
    <div class="card-footer">
    <button class="btn btn-success btn-user btn-block" type="submit"> Save
    </button>
    <form:hidden path="type" value="Withdrawal"/>
    <form:hidden path="budgetId" value="${budget.id}"/>
</form:form>
</div>