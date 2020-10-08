<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 07.10.2020
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <%@include file="fragment/header.jsp" %>
    <title>Transfer Money</title>
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

                <!-- Content Row -->
                <div class="row">


                    <!-- Form for adding NEW TRANSACTION -->
                    <div class="col-md-6 mb-4">
                        <div class="card border-left-info shadow py-2">
                            <div class="card-header">
                                <h5 class="card-title text-primary font-weight-bold text-center"> Add Money to Your
                                    Budget
                                </h5>
                                <h5 class="text-info font-weight-bolder text-center"> ${budget.name} </h5>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center justify-content-center">
                                    <form:form method="post"
                                               action="/auth/budgets/${budget.id}/transfer"
                                               modelAttribute="transactionDto">
                                    <div class="form-group">
                                        <form:label path="title" cssClass="text-primary"> Title </form:label>
                                        <form:input path="title" type="text" class="form-control form-control-user"
                                                    placeholder="" required="required"/>
                                        <form:errors path="title" cssClass="errorMessage"/>
                                    </div>

                                    <!-- optional : for passing money directly to categories? -->
                                        <%--                                <div id="selectCategory" class="form-group">--%>
                                        <%--                                    <form:label path="categoryName"--%>
                                        <%--                                                cssClass="text-primary"> Category <i--%>
                                        <%--                                            class="fas fa-info-circle infoIcon text-secondary"></i>--%>
                                        <%--                                    </form:label>--%>
                                        <%--                                    <c:forEach items="${budget.categories}" var="category">--%>
                                        <%--                                        <div class="form-check">--%>
                                        <%--                                            <form:checkbox path="categoryNames"--%>
                                        <%--                                                           cssClass="form-check-input"--%>
                                        <%--                                                           value="${category.id}"/>--%>
                                        <%--                                            <form:label path="categoryName"--%>
                                        <%--                                                        cssClass="form-check-label"> ${category.name}--%>
                                        <%--                                            </form:label>--%>
                                        <%--                                        </div>--%>
                                        <%--                                    </c:forEach>--%>
                                        <%--                                    <div class="form-check">--%>
                                        <%--                                        <input id="selectAll" type="checkbox" class="form-check-input"--%>
                                        <%--                                               value="all"/>--%>
                                        <%--                                        <label--%>
                                        <%--                                                class="form-check-label"> Select All--%>
                                        <%--                                        </label>--%>
                                        <%--                                    </div>--%>
                                        <%--                                </div>--%>

                                    <div class="form-group">
                                        <form:label path="sum" cssClass="text-primary"> Sum </form:label>
                                        <div class="input-group">
                                            <form:input path="sum" type="number" min="1" step=".01"
                                                        class="form-control form-control-user"
                                                        placeholder=""/>
                                            <div class="input-group-append">
                                                <span class="input-group-text">€</span>
                                            </div>
                                        </div>
                                        <form:errors path="sum" cssClass="errorMessage"/>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-info btn-user btn-block" type="submit"> Save
                                </button>
                                <form:hidden path="type" value="Income"/>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <%--                    --%>

                    <div class="col-xl-6 col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-header">
                                <div class="row">
                                    <h5 class="m-0 font-weight-bold text-primary text-center col-10"> Budget
                                        Transactions </h5>
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
                                        <c:forEach items="${budget.transactions}" var="transaction">
                                            <tr class="text-center">
                                                <td class="align-middle">${transaction.title}</td>
                                                <c:if test="${transaction.type.equals('Expense')}">
                                                    <td class="align-middle text-danger"> -${transaction.sum}</td>
                                                </c:if>
                                                <c:if test="${transaction.type.equals('Income')}">
                                                    <td class="align-middle text-success"> + ${transaction.sum}</td>
                                                </c:if>
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

                    <%--                    --%>

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
    <script>
        $("#selectAll").click(function () {
            $(".form-check-input").prop('checked', $(this).prop('checked'));
        });
    </script>
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
