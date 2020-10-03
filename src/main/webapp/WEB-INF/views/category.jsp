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


<html>
<head>
    <%@include file="fragment/header.jsp" %>
    <title>Title</title>
</head>
<body>
<!-- Page Heading -->
<div id="wrapper">

    <%@include file="fragment/sidebar.jsp" %>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <%@include file="fragment/topbar.jsp" %>


            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="d-sm-flex align-items-baseline justify-content-between mb-4">
                    <a href="/auth/budgets/" class="btn btn-primary"><i class="fas fa-angle-double-left"></i></a>
                    <h1 class="col-10 h3 mb-0 text-gray-800">${category.name} Category Dashboard </h1>
                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- Money Left Card -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 bg-gradient-success ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            Savings
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${category.categoryMoney}</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-euro-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Spent so far -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 bg-gradient-secondary ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            Spendings
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">XXX EUR</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-euro-sign fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Content Row -->
                <div class="row">


                    <!-- Form for adding NEW TRANSACTION directly LEAVE FOR CATEGORIES!!! -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card border-left-info h-100 shadow py-2">
                            <div class="card-header">
                                <div class="card-title font-weight-bold text-center">Add Transaction</div>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <form:form method="post" action="/auth/budgets/${budget.id}/transactions"
                                               modelAttribute="transactionDto">
                                    <div class="form-group">
                                        <form:label path="title"> Title </form:label>
                                        <form:input path="title" type="text" class="form-control form-control-user"
                                                    placeholder="Transaction Title"/>
                                        <form:errors path="title" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="type"> Type </form:label>
                                        <form:input path="type" type="text"
                                                    class="form-control form-control-user"
                                                    placeholder="Income / Spending "/>
                                        <form:errors path="type" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="sum"> Sum </form:label>
                                        <form:input path="sum" type="number"
                                                    class="form-control form-control-user"
                                                    placeholder="ex. 50 EUR"/>
                                        <form:errors path="sum" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="date"> Date </form:label>
                                        <form:input path="date" type="date"
                                                    class="form-control form-control-user"
                                                    placeholder="yyyy-MM-dd"/>
                                        <form:errors path="date" cssClass="errorMessage"/>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-info btn-user btn-block" type="submit"> Save
                                </button>
                                </form:form>
                            </div>
                        </div>
                    </div>


                    <div class="col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-header">
                                <div class="row">
                                    <h5 class="m-0 font-weight-bold text-primary text-center col-10"> Latest
                                        Transactions </h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Title</th>
                                            <th><strong>€</strong></th>
                                            <th>Type</th>
                                            <th>User</th>

                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach items="${category.transactions}" var="transaction">
                                            <tr class="text-center">
                                                <td>#</td>
                                                <td class="align-middle">${transaction.title}</td>
                                                <td class="align-middle">${transaction.sum}</td>
                                                <td class="align-middle">${transaction.type}</td>
                                                <td class="align-middle">${transaction.user.username}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->


        <%@include file="fragment/footer.jsp" %>

    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>

<div>
    <%@include file="fragment/core-js-plugins.jsp" %>
</div>

<!-- Page level plugins -->
<script src="/resources/static/vendor/chart.js/Chart.min.js"></script>
<script src="/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/resources/static/js/demo/chart-area-demo.js"></script>
<script src="/resources/static/js/demo/datatables-demo.js"></script>
<script src="/resources/static/js/demo/chart-pie-demo.js"></script>
</body>
</html>