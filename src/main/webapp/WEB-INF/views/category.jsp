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
                            ${category.name}
                            <c:choose>
                                <c:when test="${empty catName.get(category.name)}">
                                    <i class="fas fa-ellipsis-h"></i></c:when>
                                <c:otherwise>
                                    ${catName.get(category.name)}
                                </c:otherwise>
                            </c:choose>
                        </h2>
                        <div class="btn-wrapper d-inline float-right">
                            <button id="editBtn" data-toggle="modal" data-target="#editModal"
                                    data-name="${category.name}"
                                    data-budget="${category.categoryBudget}"
                                    class="btn-circle btn-warning"><i
                                    class="far fa-edit"></i></button>
                            <button id="deleteCategoryBtn" data-toggle="modal" data-target="#deleteCategoryModal"
                                    class="btn-circle btn-danger"><i
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
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Budget
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold
                                                text-primary">${category.categoryBudget}
                                            €
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-coins fa-2x text-gray-400"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- AVAILABLE -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 border-left-success">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Balance
                                        </div>
                                        <c:choose>
                                            <c:when test="${category.categoryBudget - allCategoryExpenses <= 0}">
                                                <div class="h5 mb-0 font-weight-bold
                                                text-danger">${category.categoryBudget - allCategoryExpenses}
                                                    €
                                                </div>
                                            </c:when>
                                            <c:when test="${category.categoryBudget - allCategoryExpenses <= 5}">
                                                <div class="h5 mb-0 font-weight-bold
                                                text-warning">${category.categoryBudget - allCategoryExpenses}
                                                    €
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="h5 mb-0 font-weight-bold
                                                text-success">${category.categoryBudget - allCategoryExpenses}
                                                    €
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
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 border-left-warning">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Expenses
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


                    <!-- Form for adding NEW TRANSACTION -->
                    <div class="col-xl-4 col-md-6 mb-4 ">
                        <div class="card border-left-warning h-100 shadow">
                            <div class="card-header bg-warning d-table">
                                <div class="d-table-cell align-middle">
                                    <h5 class="card-title text-white font-weight-bold text-center"> Add
                                        Transaction </h5>
                                </div>
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
                                        <%--                                        <div class="form-group">--%>
                                        <%--                                            <form:label path="type" cssClass="text-primary"> Type </form:label>--%>
                                        <%--                                            <form:select path="type" class="form-control">--%>
                                        <%--                                                <form:option value="Expense" label="--Select--" selected="selected"/>--%>
                                        <%--                                                <form:options items="${transactionType}"/>--%>
                                        <%--                                            </form:select>--%>
                                        <%--                                            <form:errors path="type" cssClass="errorMessage"/>--%>
                                        <%--                                        </div>--%>
                                    <div class="form-group">
                                        <form:label path="sum" cssClass="text-primary"> Sum </form:label>
                                        <div class="input-group">
                                            <form:input path="sum" type="number" min="1"
                                                        step=".01"
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
                                <button class="btn btn-warning btn-user btn-block" type="submit"> Save
                                </button>
                                <form:hidden path="type" value="Withdrawal"/>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <!-- Table with list of transactions -->
                    <div class="col-xl-8 col-md-6 mb-4 ">
                        <div class="card border-left-primary">
                            <div class="card-header bg-primary d-table">
                                <div class="d-table-cell align-middle">
                                    <h5 class="font-weight-bold text-white text-center card-title"> Latest
                                        Transactions </h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped" id="dataTable" width="100%" cellspacing="0">
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
                                                <td class="align-middle">${transaction.user.username}</td>
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
                                                    <button id="deleteTransactionBtn" data-toggle="modal"
                                                            data-target="#deleteTransactionModal"
                                                            data-title="${transaction.title}"
                                                            data-id="${transaction.id}"
                                                            data-category="${category.id}"
                                                            data-budget="${budget.id}"
                                                            class="btn-circle btn-danger btn-sm"><i
                                                            class="far fa-trash-alt"></i></button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <%--                                        <c:forEach items="${budget.transactions}" var="budgetTransaction">--%>
                                        <%--                                            <c:if test="${budgetTransaction.type.equals('Withdrawal') &&--%>
                                        <%--                                            empty budgetTransaction.category}">--%>
                                        <%--                                                <tr class="text-center">--%>
                                        <%--                                                    <td class="align-middle">${budgetTransaction.title}</td>--%>
                                        <%--                                                    <td class="align-middle text-danger"> ---%>
                                        <%--                                                            ${budgetTransaction.sum / budget.categories.size()}</td>--%>
                                        <%--                                                    <td class="align-middle">${budgetTransaction.user.username}</td>--%>
                                        <%--                                                    <td class="align-middle">${budgetTransaction.dateTimeAdded}</td>--%>
                                        <%--                                                </tr>--%>
                                        <%--                                            </c:if>--%>
                                        <%--                                        </c:forEach>--%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!--MODAL FORM to update Budget Category -->
                            <div id="editModal" class="modal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary d-table justify-content-between">
                                            <div class="d-table-cell align-middle">
                                                <h5 class="modal-title text-white font-weight-bolder text-center">
                                                    Edit category</h5>
                                            </div>
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="addAlert"></div>
                                            <form:form method="post"
                                                       action="/auth/budgets/${budgetId}/categories/${category.id}"
                                                       modelAttribute="category">
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label text-primary">
                                                    Name:</label>
                                                <div class="col-sm-10">
                                                    <form:input path="name" type="text" id="nameInput"
                                                                name="catName"
                                                                class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-sm-2 col-form-label text-primary">
                                                    Budget:</label>
                                                <div class="col-sm-10">
                                                    <form:input type="number" id="budgetInput" name="catBudget"
                                                                class="form-control" path="categoryBudget"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <form:hidden path="id"/>
                                            <button class="btn btn-primary" type="submit"> Save
                                                changes
                                            </button>
                                            <button type="button" class="btn btn-secondary"
                                                    data-dismiss="modal"> Close
                                            </button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--MODAL to CONFIRM and EXECUTE DELETE CATEGORY -->
                            <div id="deleteCategoryModal" class="modal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary d-table justify-content-between">
                                            <div class="d-table-cell align-middle">
                                                <h5 class="modal-title text-white font-weight-bolder text-center">
                                                    Delete category</h5>
                                            </div>
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="addAlert"></div>
                                            <p class="text-center text-primary">Are you sure you want to delete
                                                category
                                                <strong>${category.name}? </strong></p>
                                            <div class="btn-wrapper text-center">
                                                <a href="/auth/budgets/${budget.id}/categories/${category.id}/delete"
                                                   class="btn btn-primary"> Yes
                                                </a>
                                                <button type="button" class="btn btn-secondary"
                                                        data-dismiss="modal"> No
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--MODAL to CONFIRM and EXECUTE DELETE TRANSACTION -->
                            <div id="deleteTransactionModal" class="modal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary d-table justify-content-between">
                                            <div class="d-table-cell align-middle">
                                                <h5 class="modal-title text-white font-weight-bolder text-center">
                                                    Delete Transaction</h5>
                                            </div>
                                            <button type="button" class="close" data-dismiss="modal"
                                                    aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="addAlert"></div>
                                            <p class="text-center text-primary">Are you sure you want to delete
                                                transaction
                                                <strong></strong>?</p>
                                            <div class="btn-wrapper text-center">
                                                <a href="" class="btn btn-primary">Yes</a>
                                                <button type="button" class="btn btn-secondary"
                                                        data-dismiss="modal"> No
                                                </button>
                                            </div>
                                        </div>
                                    </div>
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
<script src="/resources/static/js/customizedJquery.js"></script>

<!-- Page level custom scripts -->
<script src="/resources/static/js/demo/chart-area-demo.js"></script>
<script src="/resources/static/js/demo/datatables-demo.js"></script>
<script src="/resources/static/js/demo/chart-pie-demo.js"></script>
</body>
</html>