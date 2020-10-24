<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 30.09.2020
  Time: 19:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Budgets</title>
    <jsp:include page="fragment/header.jsp"/>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
    <jsp:include page="fragment/sidebar.jsp"/>
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
            <jsp:include page="fragment/topbar.jsp"/>

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <div class="row">
                            <h4 class="m-0 font-weight-bold text-primary col-10">Your Budgets</h4>
                            <a href="/auth/budgets/form" class="btn btn-primary"> <i class="fas fa-plus"></i> </a>
                        </div>

                        <!-- Budgets Table -->
                        <div class="mt-2">
                            <h6 class="card-subtitle mb-2 text-muted">You currently have
                                <strong>${noOfBudgets}</strong>
                                <c:choose>
                                    <c:when test="${noOfBudgets == 1}">
                                        Budget
                                    </c:when>
                                    <c:otherwise>
                                        Budgets
                                    </c:otherwise>
                                </c:choose>
                            </h6>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-striped" id="dataTable" width="100%"
                                   cellspacing="0">
                                <thead>
                                <tr>
                                    <th></th>
                                    <th>Name</th>
                                    <th>Contributors</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th><strong>Total Budget</strong></th>
                                    <th><strong>Available</strong></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${budgets}" var="budget">
                                    <tr class="text-center">
                                        <c:choose>
                                        <c:when test="${now >= budget.startDate && now <= budget.endDate}">
                                        <td class="align-middle bg-success">
                                            </c:when>
                                            <c:otherwise>
                                        <td class="align-middle">
                                            </c:otherwise>
                                            </c:choose>
                                            <a href="/auth/budgets/${budget.id}"
                                               class="btn btn-primary"><i
                                                    class="fas fa-angle-double-right"></i></a>
                                        </td>
                                        <td class="align-middle">${budget.name}</td>
                                        <td class="align-middle">
                                            <c:forEach items="${budget.users}" var="user">
                                                * ${user.username}
                                            </c:forEach>
                                        </td>
                                        <td class="align-middle">${budget.startDate}</td>
                                        <td class="align-middle">${budget.endDate}</td>
                                        <td class="align-middle">${budget.budgetMoney} €</td>
                                        <td class="align-middle text-success font-weight-bolder">${budget.moneyLeft}
                                            €
                                        </td>
                                        <td>
                                            <button id="deleteBudgetBtn" data-toggle="modal"
                                                    data-target="#deleteBudgetModal"
                                                    data-name="${budget.name}"
                                                    data-id="${budget.id}"
                                                    data-categories="${budget.categories.size()}"
                                                    data-transactions="${budget.transactions.size()}"
                                                    class="btn-circle btn-secondary btn-sm"><i
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
                <jsp:include page="fragment/modals/deleteBudget.jsp"/>
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
<script src="${pageContext.request.contextPath}/resources/static/js/customizedJquery.js"></script>
<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath}/resources/static/js/demo/datatables-demo.js"></script>
</body>
</html>