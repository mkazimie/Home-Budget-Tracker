<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 02.10.2020
  Time: 00:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<html>
<head>
    <title>Budget Form</title>
    <%@include file="fragment/header.jsp" %>

</head>

<body class="bg-gradient-primary">

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-5 d-none d-lg-block bg-budget-image"></div>
                <div class="col-lg-7">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4"> Create New Budget </h1>
                        </div>
                        <div id="errorMsg" class="alert alert-danger d-none" role="alert">${error}</div>
                        <form:form method="post" action="/auth/budgets" modelAttribute="budget" cssClass="user">
                            <div class="form-group">
                                <form:label path="name"> Name </form:label>
                                <form:input path="name" type="text" class="form-control form-control-user"
                                            placeholder="2020, May, etc..."/>
                                <form:errors path="name" cssClass="errorMessage"/>
                            </div>
                            <div class="form-group">
                                <form:label path="budgetMoney"> Budget </form:label>
                                <form:input path="budgetMoney" type="number" min="0"
                                            class="form-control form-control-user"
                                            placeholder="ex. 2000 €"/>
                                <form:errors path="budgetMoney" cssClass="errorMessage"/>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <form:label path="startDate"> From </form:label>
                                    <form:input path="startDate" type="date" class="form-control form-control-user"
                                                placeholder="yyyy-MM-dd"/>
                                    <form:errors path="startDate" cssClass="errorMessage"/>
                                </div>
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <form:label path="endDate"> To </form:label>
                                    <form:input path="endDate" type="date" class="form-control form-control-user"
                                                placeholder="yyyy-MM-dd"/>
                                    <form:errors path="endDate" cssClass="errorMessage"/>
                                </div>
                            </div>
                            <button class="btn btn-primary btn-user btn-block" type="submit"> Create Budget </button>
                        </form:form>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div>
    <%@include file="fragment/core-js-plugins.jsp" %>
</div>
</body>
</html>
