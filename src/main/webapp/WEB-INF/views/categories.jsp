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
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>

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
                <div class="row">

                    <!-- Form for adding NEW CATEGORY -->
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow">
                            <div class="card-header bg-primary d-table">
                                <div class="d-table-cell align-middle">
                                    <h5 class="card-title font-weight-bold text-center text-white">Add
                                        Category</h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center justify-content-center">
                                    <div class="errorMsg alert alert-danger d-none" role="alert">${error}</div>
                                    <form:form method="post" action="/auth/budgets/${budget.id}/categories"
                                               modelAttribute="categoryDto">

                                    <!-- Category Name SELECT Input - can be toggled -->

                                    <div id="selectInput" class="form-group">
                                        <form:label path="selectedName" cssClass="text-primary"> Name </form:label>
                                        <form:select path="selectedName" class="form-control" id="selectCat">
                                            <form:option label="--Select--"
                                                         selected="selected" value=" "/>
                                            <form:options items="${categoriesIcons.keySet()}"/>
                                            <form:option value="customized"
                                                         label="Add your own"/>
                                        </form:select>
                                        <form:errors path="selectedName" cssClass="errorMessage"/>
                                    </div>

                                    <!-- Category OWN Input - can be toggled -->

                                    <div id="ownInput" class="form-group d-none">
                                        <form:label path="ownName" cssClass="text-primary"> Name </form:label>
                                        <div class="input-group">
                                            <div class="input-group-append">
                                                <div class="input-group-text">
                                                    <input type="checkbox" id="getCatList">&nbsp List
                                                </div>
                                            </div>
                                            <form:input path="ownName" type="text"
                                                        class="form-control form-control-user"
                                                        placeholder="ex. Food, Leisure..."
                                            />
                                            <form:errors path="ownName" cssClass="errorMessage"/>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <form:label path="categoryMoney"
                                                    cssClass="text-primary"> Budget </form:label>
                                        <div class="input-group">
                                            <form:input path="categoryMoney" type="number" min="1" step=".1"
                                                        class="form-control form-control-user"
                                                        placeholder="" required="required"/>
                                            <div class="input-group-append">
                                                <span class="input-group-text">€</span>
                                            </div>
                                        </div>
                                        <form:errors path="categoryMoney" cssClass="errorMessage"/>
                                    </div>

                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-success btn-user btn-block" type="submit"> Save
                                </button>
                                </form:form>
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
                                                        <c:when test="${empty categoriesIcons.get(category.name)}">
                                                            <i class="fas fa-ellipsis-h"></i> </c:when>
                                                        <c:otherwise>
                                                            ${categoriesIcons.get(category.name)}
                                                        </c:otherwise>
                                                    </c:choose>
                                                    &nbsp;&nbsp; ${category.name}
                                                </td>
                                                <td class="align-middle">${category.categoryBudget} €</td>

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
                    <div>
                        <jsp:include page="fragment/modals/deleteCategory.jsp"/>
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
    <script src="/resources/static/js/customizedJquery.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/static/js/demo/chart-area-demo.js"></script>
    <script src="/resources/static/js/demo/datatables-demo.js"></script>
    <script src="/resources/static/js/demo/chart-pie-demo.js"></script>
</body>
</html>
