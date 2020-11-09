<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Budgets</title>
    <jsp:include page="fragment/header.jsp"/>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
    <jsp:include page="fragment/side-bar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <jsp:include page="fragment/top-bar.jsp"/>
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
                <div class="card shadow mb-4">
                    <div class="card-header">
                        <div class="row d-table">
                            <h4 class="ml-3 font-weight-bold text-primary">Your Activity Log</h4>
                        </div>
                        <!-- Budgets Table -->
                        <div class="mx-2 my-2">
                            <p class="card-subtitle text-muted">You have
                                <strong>${allTransactionsByUser.size()}</strong>
                                <c:choose>
                                    <c:when test="${allTransactionsByUser.size() == 1}">
                                        Transaction
                                    </c:when>
                                    <c:otherwise>
                                        Transactions
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                <div
                                        class="confirmSuccessTransaction alert alert-success d-none text-center font-weight-bolder"
                                     role="alert"></div>
                                <thead>
                                <tr class="text-center">
                                    <th> Added</th>
                                    <th> Title</th>
                                    <th><strong> € </strong></th>
                                    <th> Budget </th>
                                    <th> Category </th>
                                    <th> Transaction Date</th>
                                    <th> Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${allTransactionsByUser}" var="transaction">
                                    <tr class="text-center">
                                        <fmt:parseDate value="${transaction.added}"
                                                       pattern="yyyy-MM-dd'T'HH:mm"
                                                       var="parsedDateTime" type="both"/>
                                        <td class="align-middle text-gray-800 font-sm">
                                            <fmt:formatDate
                                                    pattern="dd/MM/yyyy HH:mm"
                                                    value="${parsedDateTime }"
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
                                        <td class="align-middle">
                                            <a href="/auth/budgets/${transaction.category.budget.id}"
                                               class="btn btn-outline-primary font-weight-bolder">
                                                    ${transaction.category.budget.name}
                                            </a>
                                        </td>
                                        <td class="align-middle">
                                            <a href="/auth/budgets/${transaction.category.budget.id}/categories/${transaction.category.id}"
                                               class="btn btn-outline-dark font-weight-bolder">
                                                    ${transaction.category.name}
                                            </a>
                                        </td>
                                        <td class="align-middle">${transaction.category.name}</td>
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
                                                    data-toggle="modal"
                                                    data-target="#editTransactionModal"
                                                    data-title="${transaction.title}"
                                                    data-id="${transaction.id}"
                                                    data-sum="${transaction.sum}"
                                                    data-date="${transaction.date}"
                                                    data-category="${transaction.category.id}"
                                                    data-budget="${transaction.category.budget.id}"
                                                    class="btn btn-circle btn-outline-warning btn-sm"><i
                                                    class="far fa-edit"></i></button>
                                            <button
                                                    data-toggle="modal"
                                                    data-target="#deleteTransactionModal"
                                                    data-title="${transaction.title}"
                                                    data-id="${transaction.id}"
                                                    data-category="${transaction.category.id}"
                                                    data-budget="${transaction.category.budget.id}"
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
                <!-- Include Modals-->
                <jsp:include page="fragment/modals/delete-budget.jsp"/>
                <jsp:include page="fragment/modals/edit-transaction.jsp"/>
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
<!-- Scroll to Top Button-->
<div>
    <jsp:include page="fragment/scroll-btn.jsp"/>
</div>
<!--App level plugins-->
<div>
    <jsp:include page="fragment/core-js-plugins.jsp"/>
</div>
<!-- Page level plugins -->
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/customized-jQuery.js"></script>
<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath}/resources/static/js/demo/datatables-demo.js"></script>
</body>
</html>