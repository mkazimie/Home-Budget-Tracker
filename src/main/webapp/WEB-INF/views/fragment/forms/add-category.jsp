<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="card-body">
<div class="row no-gutters align-items-center justify-content-center text-center">
<form:form id="categoryForm" method="post" action=""
           modelAttribute="categoryDto">
    <div class="generalErrorMessage alert alert-danger d-none" role="alert"></div>
    <div id="selectInput" class="form-group">
        <form:label path="selectedName" cssClass="text-dark"> Name </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <form:select path="selectedName" class="form-control" id="selectCat">
            <form:option label="--Select--"
                         selected="selected" value=" "/>
            <form:options items="${categoryIconsMap.keySet()}"/>
            <form:option value="customized"
                         label="Add your own"/>
        </form:select>
    </div>
    <div id="ownInput" class="form-group d-none">
        <form:label path="ownName" cssClass="text-dark"> Name </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <div class="input-group">
            <div class="input-group-append">
                <div class="input-group-text">
                    <input type="checkbox" id="getCatList">&nbsp List
                </div>
            </div>
            <form:input path="ownName" type="text"
                        class="form-control form-control-user"
                        placeholder="ex. Food, Leisure..."
                        id="ownName"/>
        </div>
    </div>
    <div class="form-group">
        <form:label path="categoryAllowance"
                    cssClass="text-dark"> Budget </form:label>
        <div class="errorMessage alert alert-danger d-none" role="alert"></div>
        <div class="input-group">
            <form:input path="categoryAllowance" type="number" min="1" step=".01"
                        class="form-control form-control-user"
                        placeholder="" id="categoryAllowance"/>
            <div class="input-group-append">
                <span class="input-group-text">€</span>
            </div>
        </div>
    </div>
    </div>
    </div>
    <div class="card-footer bg-white">
    <button class="btn btn-success btn-user btn-block" type="submit"> Save
    </button>
    <form:hidden path="budgetId" value="${budget.id}"/>
</form:form>
</div>