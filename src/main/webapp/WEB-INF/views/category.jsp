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
    <title>Category View</title>
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
                    <li class="breadcrumb-item">
                        <a href="/auth/budgets/${budget.id}">
                            <i class="fas fa-angle-double-left"></i>
                            ${budget.name} Dashboard </a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="/auth/budgets/${budget.id}/categories">
                            <i class="fas fa-angle-double-left"></i>
                            ${budget.name} Categories </a>
                    </li>
                </ol>
            </nav>

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="container-fluid p-0 mb-4">
                    <div class="text-center">
                        <h2 class="d-inline text-primary font-weight-bolder">
                            <c:choose>
                                <c:when test="${empty categoryIconsMap.get(category.name)}">
                                    <i class="fas fa-ellipsis-h"></i></c:when>
                                <c:otherwise>
                                    ${categoryIconsMap.get(category.name)}
                                </c:otherwise>
                            </c:choose>
                            ${category.name}
                        </h2>
                        <div class="btn-wrapper d-inline float-right">
                            <button id="editBtn" data-toggle="modal" data-target="#editModal"
                                    data-name="${category.name}"
                                    data-allowance="${category.categoryAllowance}"
                                    data-budget="${budget.id}"
                                    data-id="${category.id}"
                                    class="btn btn-circle btn-outline-warning"><i
                                    class="far fa-edit"></i></button>
                            <button id="deleteBtn" data-toggle="modal"
                                    data-target="#deleteCategoryModal"
                                    data-name="${category.name}"
                                    data-id="${category.id}"
                                    data-budget="${budget.id}"
                                    class="btn btn-circle btn-outline-danger"><i
                                    class="far fa-trash-alt"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <!-- BUDGET -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 border-left-info">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
                                            Allowance
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold
                                                text-dark">${category.categoryAllowance}€
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-coins fa-2x text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- BALANCE -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 border-left-success">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
                                            Balance
                                        </div>
                                        <c:choose>
                                            <c:when test="${category.categoryAllowance - allCategoryExpenses <= 0}">
                                                <div class="h5 mb-0 font-weight-bold
                                                text-danger">${category.categoryAllowance - allCategoryExpenses}€
                                                </div>
                                            </c:when>
                                            <c:when test="${category.categoryAllowance - allCategoryExpenses <= 5}">
                                                <div class="h5 mb-0 font-weight-bold
                                                text-warning">${category.categoryAllowance - allCategoryExpenses}€
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="h5 mb-0 font-weight-bold
                                                text-success">${category.categoryAllowance - allCategoryExpenses}€
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-hand-holding-usd fa-2x text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- EXPENSES -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 border-left-warning">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-lg font-weight-bold text-primary text-uppercase mb-1">
                                            Expenses
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-warning">${allCategoryExpenses} €
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file-invoice-dollar fa-2x text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content Row -->
                <div class="row">
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-warning h-100 shadow">
                            <div class="card-header bg-warning d-table">
                                <div class="d-table-cell align-middle">
                                    <h4 class="card-title text-white font-weight-bold text-center"> Add
                                        Transaction </h4>
                                </div>
                            </div>
                    <jsp:include page="fragment/forms/add-transaction.jsp"/>
                        </div>
                    </div>
                    <!-- Table with list of transactions -->
                    <div class="col-xl-8 col-md-6 mb-4 ">
                        <div class="card border-left-primary">
                            <div class="card-header bg-primary d-table">
                                <div class="d-table-cell align-middle">
                                    <h4 class="font-weight-bold text-white text-center card-title"> Latest
                                        Transactions </h4>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped text-dark" id="dataTable" width="100%"
                                           cellspacing="0">
                                        <thead>
                                        <tr class="text-center">
                                            <th> Added</th>
                                            <th> Title</th>
                                            <th><strong> € </strong></th>
                                            <th> User</th>
                                            <th> Transaction Date</th>
                                            <th> Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${category.transactions}" var="transaction">
                                            <tr class="text-center">
                                                <fmt:parseDate value="${ transaction.dateTimeAdded }"
                                                               pattern="yyyy-MM-dd'T'HH:mm"
                                                               var="parsedDateTime" type="both"/>
                                                <td class="align-middle text-gray-800 font-sm">
                                                    <fmt:formatDate
                                                            pattern="dd/MM/yyyy HH:mm"
                                                            value="${ parsedDateTime }"
                                                    />
                                                </td>
                                                <td class="align-middle">${transaction.title}</td>
                                                <c:choose>
                                                    <c:when test="${transaction.type.equals('Withdrawal')}">
                                                        <td class="align-middle text-danger"> -${transaction.sum}€
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td class="align-middle text-success">
                                                            +${transaction.sum}€
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td class="align-middle">${currentUser.username}</td>
                                                <fmt:parseDate value="${ transaction.date }"
                                                               pattern="yyyy-MM-dd"
                                                               var="parsedDate" type="both"/>
                                                <td class="align-middle">
                                                    <fmt:formatDate
                                                            pattern="dd/MM/yyyy"
                                                            value="${ parsedDate }"
                                                    />
                                                </td>
                                                <td class="align-middle">
                                                    <button
                                                            id="editTransactionBtn"
                                                            data-toggle="modal"
                                                            data-target="#editTransactionModal"
                                                            data-title="${transaction.title}"
                                                            data-id="${transaction.id}"
                                                            data-sum="${transaction.sum}"
                                                            data-date="${transaction.date}"
                                                            data-category="${category.id}"
                                                            data-budget="${budget.id}"
                                                            class="btn btn-circle btn-outline-warning btn-sm"><i
                                                            class="far fa-edit"></i></button>
                                                    <button id="deleteTransactionBtn" data-toggle="modal"
                                                            data-target="#deleteTransactionModal"
                                                            data-title="${transaction.title}"
                                                            data-id="${transaction.id}"
                                                            data-category="${category.id}"
                                                            data-budget="${budget.id}"
                                                            class="btn btn-circle btn-outline-danger btn-sm"><i
                                                            class="far fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Insert Modals -->
                    <jsp:include page="fragment/modals/edit-category.jsp"/>
                    <jsp:include page="fragment/modals/edit-transaction.jsp"/>
                    <jsp:include page="fragment/modals/delete-category.jsp"/>
                    <jsp:include page="fragment/modals/delete-transaction.jsp"/>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
            <jsp:include page="fragment/footer.jsp"/>
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
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