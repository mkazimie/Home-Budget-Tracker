<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- Form for adding NEW CATEGORY -->
<div class="errorMsg alert alert-danger d-none" role="alert">${error}</div>
<form:form method="post" action="/auth/budgets/${budget.id}/categories"
           modelAttribute="categoryDto">
    <!-- Category selected input - can be toggled -->
    <div id="selectInput" class="form-group">
        <form:label path="selectedName" cssClass="text-primary"> Name </form:label>
        <form:select path="selectedName" class="form-control" id="selectCat">
            <form:option label="--Select--"
                         selected="selected" value=" "/>
            <form:options items="${categoryIconsMap.keySet()}"/>
            <form:option value="customized"
                         label="Add your own"/>
        </form:select>
        <form:errors path="selectedName" cssClass="errorMessage"/>
    </div>
    <!-- Category own input - can be toggled -->
    <div id="ownInput" class="form-group d-none">
        <form:label path="ownName" cssClass="text-primary"> Name </form:label>
        <div class="input-group">
            <div class="input-group-append">
                <div class="input-group-text">
                    <input type="checkbox" id="getCatList">&nbsp List
                </div>
            </div>
            <form:input path="ownName" type="text"
                        class="form-control form-control-user"
                        placeholder="ex. Food, Leisure..."
                        id="ownName"
            />
            <form:errors path="ownName" cssClass="errorMessage"/>
        </div>
    </div>
    <div class="form-group">
        <form:label path="categoryMoney"
                    cssClass="text-primary"> Budget </form:label>
        <div class="input-group">
            <form:input path="categoryMoney" type="number" min="1" step=".01"
                        class="form-control form-control-user"
                        placeholder="" required="required" id="categoryMoney"/>
            <div class="input-group-append">
                <span class="input-group-text">€</span>
            </div>
        </div>
        <form:errors path="categoryMoney" cssClass="errorMessage"/>
</div>
<button id="addCategory" class="btn btn-success btn-user btn-block" type="submit"> Save</button>
</form:form>