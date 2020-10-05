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
    <title>Category View</title>
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
                    <a href="/auth/budgets/${budget.id}"
                       class="btn btn-primary"><i class="fas fa-angle-double-left"></i></a>
                    <h1 class="col-10 h3 mb-0 text-gray-800">${category.name} Category Dashboard </h1>
                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- Money Left Card -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 bg-gradient-info">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            LEFT
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
                        <div class="card h-100 shadow py-2 bg-gradient-warning">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            SPENT
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${sumOfCategoryTransactions}</div>
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


                    <!-- Form for adding NEW TRANSACTION -->
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-info h-100 shadow py-2">
                            <div class="card-header">
                                <h5 class="card-title text-primary font-weight-bold text-center"> Add Expense </h5>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center justify-content-center">
                                    <form:form method="post"
                                               action="/auth/budgets/${budget.id}/categories/${category.id}/transactions"
                                               modelAttribute="transactionDto">
                                    <div class="form-group">
                                        <form:label path="title" cssClass="text-primary"> Title </form:label>
                                        <form:input path="title" type="text" class="form-control form-control-user"
                                                    placeholder="" required="required"/>
                                        <form:errors path="title" cssClass="errorMessage"/>
                                    </div>
<%--                                    <div class="form-group">--%>
<%--                                        <form:label path="type" cssClass="text-primary"> Type </form:label>--%>
<%--                                        <form:select path="type" class="form-control">--%>
<%--                                            <form:option value="Expense" label="--Select--" selected="selected"/>--%>
<%--                                            <form:options items="${transactionType}"/>--%>
<%--                                        </form:select>--%>
<%--                                        <form:errors path="type" cssClass="errorMessage"/>--%>
<%--                                    </div>--%>
                                    <div class="form-group">
                                        <form:label path="sum" cssClass="text-primary"> Sum </form:label>
                                        <div class="input-group">
                                            <form:input path="sum" type="number" min="1"
                                                        max="${category.categoryMoney}" step=".01"
                                                        class="form-control form-control-user"
                                                        placeholder=""/>
                                            <div class="input-group-append">
                                                <span class="input-group-text">€</span>
                                            </div>
                                        </div>
                                        <form:errors path="sum" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="date" cssClass="text-primary"> Date </form:label>
                                        <form:input path="date" type="date" min="${budget.startDate}"
                                                    max="${budget.endDate}"
                                                    class="form-control form-control-user"
                                                    placeholder="yyyy-MM-dd" required="required"/>
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

                    <!-- Table with list of transactions -->
                    <div class="col-xl-6 col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-header">
                                <div class="row">
                                    <h5 class="m-0 font-weight-bold text-primary text-center col-10"> Latest
                                        Expenses </h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr class="text-center">
                                            <th>Title</th>
                                            <th><strong>€</strong></th>
                                            <th>User</th>
                                            <th>Date</th>

                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach items="${category.transactions}" var="transaction">
                                            <tr class="text-center">
                                                <td class="align-middle">${transaction.title}</td>
                                                <td class="align-middle">${transaction.sum}</td>
                                                <td class="align-middle">${transaction.user.username}</td>
                                                <td class="align-middle">${transaction.date}</td>
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