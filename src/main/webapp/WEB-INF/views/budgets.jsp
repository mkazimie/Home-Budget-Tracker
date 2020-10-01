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
    <%@include file="fragment/header.jsp" %>

</head>
<body id="page-top">

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


                <%--                        <!-- Page Heading -->--%>
                <%--                        <h1 class="h3 mb-2 text-gray-800">Budgets</h1>--%>
                <%--                        <p class="mb-4"> Your Budgets </p>--%>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <div class="row">
                            <h4 class="m-0 font-weight-bold text-primary col-10">Your Budgets</h4>
<%--                            <form action="/auth/budgets" method="post">--%>
                                <a href="/auth/budgets/form" class="btn btn-primary"> + </a>
<%--                                <button class="btn btn-primary"><i class="fas fa-plus"></i></button>--%>
<%--                            </form>--%>
                        </div>


                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Contributors</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th> $$$</th>
                                    <th> Go</th>
                                </tr>
                                </thead>
                                <tfoot>
                                <tr>
                                    <th>Name</th>
                                    <th>Contributors</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th> $$$</th>
                                    <th> Go</th>
                                </tr>
                                </tfoot>

                                <tbody>
                                <c:forEach items="${budgets}" var="budget">
                                    <tr class="text-center">
                                        <td class="align-middle">${budget.name}</td>
                                        <td class="align-middle">
                                            <c:forEach items="${budget.users}" var="user">
                                                ${user.username}
                                            </c:forEach>
                                        </td>
                                        <td class="align-middle">${budget.startDate}</td>
                                        <td class="align-middle">${budget.endDate}</td>
                                        <td class="align-middle">$$$</td>
                                        <td class="align-middle"><a href="#">Details</a></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
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
<script src="/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/resources/static/js/demo/datatables-demo.js"></script>

</body>
</html>
