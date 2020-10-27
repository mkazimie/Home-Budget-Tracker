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
    <jsp:include page="fragment/header.jsp"/>
    <title>Categories</title>
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
                </ol>
            </nav>

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="d-sm-flex align-items-baseline justify-content-center mb-4">
                    <h2 class="mb-0 text-center text-primary font-weight-bolder">${budget.name} Categories
                    </h2>
                </div>

                <!-- Content Row -->
                <!--ADD CAT FORM-->
                <div class="row">
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow">
                            <div class="card-header bg-primary d-table">
                                <div class="d-table-cell align-middle">
                                    <h5 class="card-title font-weight-bold text-center text-white">Add Category</h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center justify-content-center">
                                    <jsp:include page="fragment/forms/add-category.jsp"/>
                                </div>
                            </div>
                        </div>
                    </div>

                        <!-- Table displaying ALL CATEGORIES for this budget -->
                        <div class="col-xl-7 col-md-6 mb-4 ">
                            <div class="card border-left-primary shadow h-100">
                                <div class="card-header bg-primary d-table">
                                    <div class="d-table-cell align-middle">
                                        <h5 class="card-title font-weight-bold text-center text-white">
                                            Categories</h5>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
                                            <thead>
                                            <tr>
                                                <th></th>
                                                <th>Name</th>
                                                <th><strong>Budget</strong></th>
                                                <th><strong>Available</strong></th>
                                                <th></th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${budget.categories}" var="category">
                                                <tr>
                                                    <td class="align-middle"><a
                                                            href="/auth/budgets/${budget.id}/categories/${category.id}"
                                                            class="btn btn-success"><i
                                                            class="fas fa-angle-double-right"></i></a>
                                                    </td>
                                                    <td
                                                            class="align-middle">
                                                        <c:choose>
                                                            <c:when test="${empty categoryIconsMap.get(category.name)}">
                                                                <i class="fas fa-ellipsis-h"></i> </c:when>
                                                            <c:otherwise>
                                                                ${categoryIconsMap.get(category.name)}
                                                            </c:otherwise>
                                                        </c:choose>
                                                        &nbsp;&nbsp; ${category.name}
                                                    </td>
                                                    <td class="align-middle">${category.categoryAllowance} €</td>
                                                    <c:choose>
                                                        <c:when test="${categoryBalanceMap.get(category.name) > 0}">
                                                            <td class="align-middle
                                                     text-success">${categoryBalanceMap.get(category.name)} €
                                                            </td>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <td class="align-middle
                                                     text-danger">${categoryBalanceMap.get(category.name)} €
                                                            </td>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <td>
                                                        <button id="deleteBtn" data-toggle="modal"
                                                                data-target="#deleteCategoryModal"
                                                                data-name="${category.name}"
                                                                data-id="${category.id}"
                                                                data-budget="${budget.id}"
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
                        </div>
                    </div>
                    <!-- Content Row -->
                    <div class="row">
                        <!--Insert Modals -->
                        <jsp:include page="fragment/modals/deleteCategory.jsp"/>
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
    <script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/static/js/customizedJquery.js"></script>
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/resources/static/js/demo/datatables-demo.js"></script>
</body>
</html>