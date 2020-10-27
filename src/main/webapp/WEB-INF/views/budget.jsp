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
<body>
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
                                    class="btn-circle btn-warning"><i
                                    class="far fa-edit"></i></button>
                            <button id="deleteBudgetBtn" data-toggle="modal"
                                    data-target="#deleteBudgetModal"
                                    data-name="${budget.name}"
                                    data-id="${budget.id}"
                                    data-categories="${budget.categories.size()}"
                                    data-transactions="${budget.transactions.size()}"
                                    class="btn-circle btn-danger"><i
                                    class="far fa-trash-alt"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- BUDGET -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 bg-gradient-info ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            Allowance
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${budgetAllowance} €</div>
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
                        <c:choose>
                        <c:when test="${budgetAllowance - allBudgetExpenses <= 0}">
                        <div class="card h-100 shadow py-2 bg-gradient-danger ">
                            </c:when>
                            <c:when test="${budgetAllowance - allBudgetExpenses  <= 5}">
                            <div class="card h-100 shadow py-2 bg-gradient-warning ">
                                </c:when>
                                <c:otherwise>
                                <div class="card h-100 shadow py-2 bg-gradient-success ">
                                    </c:otherwise>
                                    </c:choose>
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                    Current Balance
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold
                                                text-white">${budgetAllowance - allBudgetExpenses }€
                                                </div>
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
                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                    All Expenses
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
                                <div class="card border-left-primary shadow">
                                    <div class="card-header bg-primary">
                                        <h5 class="card-title text-white font-weight-bold text-center"> Categories
                                        </h5>
                                        <div class="text-center">${budget.categories.size()} categories in this budget
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center justify-content-center">
                                            <a href="/auth/budgets/${budget.id}/categories"
                                               class="btn-success btn-circle btn-lg">
                                                <i class="fas fa-angle-double-right text-gray-100"></i>
                                            </a>
                                            <!-- Pie Chart -->
                                            <div class="chart-pie pt-4 pb-2">
                                                <canvas id="myPieChart"></canvas>
                                            </div>
                                            <div class="mt-4 text-center small">
                                                <span class="mr-2"><i
                                                        class="fas fa-circle text-primary"></i> Direct</span>
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
                                <div class="card border-primary">
                                    <div class="card-header border-bottom-primary d-table">
                                        <div class="d-table-cell align-middle">
                                            <h4 class="card-title text-primary font-weight-bold text-center"> Add
                                                Category </h4>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="btn-wrapper text-center">
                                            <button class="toggle-form btn-circle btn-lg btn-info" type="button"
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
                                <div class="card border-primary">
                                    <div class="card-header border-bottom-info d-table">
                                        <div class="d-table-cell align-middle">
                                            <h4 class="card-title text-primary font-weight-bold text-center"> Add
                                                Transaction </h4>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="btn-wrapper text-center">
                                            <button class="toggle-form btn-circle btn-lg btn-info" type="button"
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