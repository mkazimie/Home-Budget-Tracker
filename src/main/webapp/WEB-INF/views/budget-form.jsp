<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<html>
<head>
    <title>Budget Form</title>
    <jsp:include page="fragment/header.jsp"/>
</head>
<body class="bg-gradient-primary">
<!-- Page Wrapper -->
<div id="wrapper">
    <jsp:include page="fragment/side-bar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <jsp:include page="fragment/top-bar.jsp"/>
            <div id="budget-form-card" class="card o-hidden border-0 shadow-lg mx-5 my-5">
                <div class="card-body p-0">
                    <!-- Nested Row within Card Body -->
                    <div class="row">
                        <div class="col-lg-5 d-none d-lg-block bg-budget-image"></div>
                        <div class="col-lg-7">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4"> Create New Budget </h1>
                                </div>
                                <div class="errorMsg alert alert-danger d-none" role="alert">${error}</div>
                                <form:form id="budgetForm" method="post" action="/auth/budgets" modelAttribute="budget"
                                           cssClass="user">
                                    <div class="form-group">
                                        <form:label path="name" cssClass="text-primary"> Name </form:label>
                                        <form:input path="name" type="text" class="form-control"
                                                    placeholder="ex. May, 2021..."/>
                                        <form:errors path="name" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group row">
                                        <div class="col-sm-6 mb-3 mb-sm-0">
                                            <form:label path="startDate" cssClass="text-primary"> From </form:label>
                                            <form:input id="startDate" path="startDate" type="date" class="form-control"
                                                        placeholder="yyyy-MM-dd"/>
                                            <form:errors path="startDate" cssClass="errorMessage"/>
                                        </div>
                                        <div class="col-sm-6 mb-3 mb-sm-0">
                                            <form:label path="endDate" cssClass="text-primary"> To </form:label>
                                            <form:input id="endDate" path="endDate" min="${budget.startDate}"
                                                        type="date"
                                                        class="form-control"
                                                        placeholder="yyyy-MM-dd"/>
                                            <form:errors path="endDate" cssClass="errorMessage"/>
                                        </div>
                                    </div>
                                    <button class="btn btn-primary btn-block mb-0 mt-5" type="submit">Save</button>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <jsp:include page="fragment/footer.jsp"/>
        </div>
    </div>
</div>
        <!--App level plugins-->
        <div>
            <jsp:include page="fragment/core-js-plugins.jsp"/>
        </div>

        <!-- Page level plugins -->
        <script src="${pageContext.request.contextPath}/resources/static/js/customized-jQuery.js"></script>
</body>
</html>