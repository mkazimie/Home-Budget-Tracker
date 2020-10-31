<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 28.09.2020
  Time: 21:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <jsp:include page="fragment/header.jsp"/>
    <title>Title</title>
</head>
<body class="bootstrap-overrides bg-gradient-light">
<!-- Page Wrapper -->
<div id="wrapper">
    <jsp:include page="fragment/sidebar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <jsp:include page="fragment/topbar.jsp"/>
            <!-- Bread Crumbs-->
            <nav aria-label="breadcrumb bg-info">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item ml-3"><a href="/auth/budgets">
                        <i class="fas fa-angle-double-left"></i>
                        Home </a></li>
                </ol>
            </nav>

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="container-fluid p-0 mb-4">
                    <div class="text-center">
                        <h2 class="d-inline text-primary font-weight-bolder">
                            ${budget.name} Budget Dashboard
                        </h2>
                        <div class="btn-wrapper d-inline float-right">
                            <button id="editBudgetBtn" data-toggle="modal" data-target="#editBudgetModal"
                                    data-name="${budget.name}"
                                    data-start="${budget.startDate}"
                                    data-end="${budget.endDate}"
                                    data-id="${budget.id}"
                                    class="btn btn-circle btn-outline-warning"><i
                                    class="far fa-edit"></i></button>
                            <button id="deleteBudgetBtn" data-toggle="modal"
                                    data-target="#deleteBudgetModal"
                                    data-name="${budget.name}"
                                    data-id="${budget.id}"
                                    data-categories="${budget.categories.size()}"
                                    class="btn btn-circle btn-outline-danger"><i
                                    class="far fa-trash-alt"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- BUDGET -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 bg-light border-left-info">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-uppercase mb-1">
                                            Allowance
                                        </div>
                                        <div class="h5 mb-0 text-info font-weight-bold">${budgetAllowance} €</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-coins fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- BALANCE -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 border-left-success ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-black-50 text-uppercase mb-1">
                                            Balance
                                        </div>
                                        <c:choose>
                                            <c:when test="${budgetAllowance - allBudgetExpenses <= 0}">
                                                <div class="h5 mb-0 font-weight-bold
                                                        text-danger">${budgetAllowance - allBudgetExpenses }€
                                                </div>
                                            </c:when>
                                            <c:when test="${budgetAllowance - allBudgetExpenses  <= 5}">
                                                <div class="h5 mb-0 font-weight-bold
                                                        text-warning">${budgetAllowance - allBudgetExpenses }€
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="h5 mb-0 font-weight-bold
                                                        text-success">${budgetAllowance - allBudgetExpenses }€
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-hand-holding-usd fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- EXPENSES -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 border-left-warning ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-black-50 text-uppercase mb-1">
                                            Expenses
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-warning">${allBudgetExpenses}€</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file-invoice-dollar fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- Go To Categories -->
                    <div class="col-xl-4 col-md-6 mb-4">
                        <div class="card border-left-dark border-bottom-dark shadow">
                            <div class="card-header bg-gradient-dark">
                                <h4 class="card-title text-white font-weight-bold text-center"> Categories
                                </h4>
                                <div class="text-center text-white-50">${budget.categories.size()}
                                    <c:choose>
                                        <c:when test="${budget.categories.size() == 1}">
                                            category
                                        </c:when>
                                        <c:otherwise>
                                            categories
                                        </c:otherwise>
                                    </c:choose>
                                    in this budget
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center justify-content-center">
                                    <a href="/auth/budgets/${budget.id}/categories"
                                       class="btn btn-outline-success btn-circle btn-lg">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                    <!-- Pie Chart -->
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="myPieChart"></canvas>
                                    </div>
                                    <div class="mt-4 text-center small">
                                                <span class="mr-2"><i
                                                        class="fas fa-circle text-black-50"></i> Direct</span>
                                        <span class="mr-2"><i
                                                class="fas fa-circle text-success"></i> Social</span>
                                        <span class="mr-2"><i
                                                class="fas fa-circle text-info"></i> Referral</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Add Category Toggled Form-->
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-primary border-bottom-primary">
                            <div class="card-header bg-primary d-table">
                                <div class="d-table-cell align-middle">
                                    <h4 class="card-title font-weight-bold text-white text-center"> Add
                                        Category </h4>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="btn-wrapper text-center">
                                    <button class="btn btn-circle btn-lg btn-outline-success toggle-form"
                                            type="button"
                                            data-toggle="collapse" data-target="#addCategoryForm"
                                            aria-expanded="false"
                                            aria-controls="collapseExample">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                    <div id="addCategoryForm" class="collapse my-3">
                                        <jsp:include page="fragment/forms/add-category.jsp"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Add Transaction Toggled Form-->
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-dark border-bottom-dark">
                            <div class="card-header bg-dark d-table">
                                <div class="d-table-cell align-middle">
                                    <h4 class="card-title text-white font-weight-bold text-center"> Add
                                        Transaction </h4>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="btn-wrapper text-center">
                                    <button class="btn btn-circle btn-lg btn-outline-success toggle-form"
                                            type="button"
                                            data-toggle="collapse" data-target="#addTransactionForm"
                                            aria-expanded="false"
                                            aria-controls="collapseExample">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                    <div id="addTransactionForm" class="collapse my-3">
                                        <jsp:include page="fragment/forms/add-transaction.jsp"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Insert Modals -->
        <div>
            <jsp:include page="fragment/modals/editBudget.jsp"/>
            <jsp:include page="fragment/modals/deleteBudget.jsp"/>
            <jsp:include page="fragment/modals/deleteTransaction.jsp"/>
        </div>

        <!-- End Page Content -->
    </div>
    <!-- End of Main Content -->
</div>
<!-- End of Content Wrapper -->
</div>
<jsp:include page="fragment/footer.jsp"/>
</div>
<!-- Scroll to Top Button-->
<div>
    <jsp:include page="fragment/scroll-btn.jsp"/>
</div>
<!--App level plugins-->
<div>
    <jsp:include page="fragment/core-js-plugins.jsp"/>
</div>
<!-- Page level plugins -->
<script src="${pageContext.request.contextPath}/resources/static/vendor/chart.js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/customizedJquery.js"></script>

<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath}/resources/static/js/demo/chart-area-demo.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/demo/datatables-demo.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/demo/chart-pie-demo.js"></script>
</body>
</html>