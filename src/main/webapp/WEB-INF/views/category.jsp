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
                    <a href="/auth/budgets/${budget.id}/categories"
                       class="btn btn-primary"><i class="fas fa-angle-double-left"></i></a>
                    <h1 class="col-10 h3 mb-0 text-primary font-weight-bolder">${category.name} </h1>
                    <button id="editBtn" data-toggle="modal" data-target="#editModal"
                            data-name="${category.name}"
                            data-budget="${category.categoryBudget}"
                            data-available="${budget.budgetMoney - allCategoryBudgets}"
                            class="btn-circle btn-warning"><i
                            class="far fa-edit"></i></button>
                    <button id="deleteBtn"
                            class="btn-circle btn-danger"><i
                            class="far fa-trash-alt"></i></button>

                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- BUDGET -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card h-100 shadow py-2 bg-gradient-info ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Budget
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${category.categoryBudget}
                                            €
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-coins fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- AVAILABLE -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 bg-gradient-success ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Balance
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${category.categoryBudget -
                                        allCategoryExpenses} €</div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-hand-holding-usd fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- SPENDINGS -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 bg-gradient-warning ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            ${category.name} Expenses
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${allCategoryExpenses} €
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-file-invoice-dollar fa-2x text-gray-300"></i>
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
                            <div class="card-header">
                                <h5 class="card-title text-warning font-weight-bold text-center"> Register Expense </h5>
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
                                        <%--                                <div class="form-group">--%>
                                        <%--                                    <form:label path="type" cssClass="text-primary"> Type </form:label>--%>
                                        <%--                                    <form:select path="type" class="form-control">--%>
                                        <%--                                        <form:option value="Expense" label="--Select--" selected="selected"/>--%>
                                        <%--                                        <form:options items="${transactionType}"/>--%>
                                        <%--                                    </form:select>--%>
                                        <%--                                    <form:errors path="type" cssClass="errorMessage"/>--%>
                                        <%--                                </div>--%>
                                    <div class="form-group">
                                        <form:label path="sum" cssClass="text-primary"> Sum </form:label>
                                        <div class="input-group">
                                            <form:input path="sum" type="number" min="1"
                                                        max="${category.categoryBudget - allCategoryExpenses}" step=".01"
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
                    <div class="col-xl-6 col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-header">
                                <div class="row">
                                    <h5 class="m-0 font-weight-bold text-primary text-center col-10"> Latest
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
                                        <c:forEach items="${category.transactions}" var="transaction">
                                            <tr class="text-center">
                                                <td class="align-middle">${transaction.title}</td>
                                                <c:choose>
                                                    <c:when test="${transaction.type.equals('Withdrawal')}">
                                                        <td class="align-middle text-danger"> -${transaction.sum}</td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td class="align-middle text-success"> +${transaction.sum}</td>
                                                    </c:otherwise>
                                                </c:choose>
                                                <td class="align-middle">${transaction.user.username}</td>
                                                <td class="align-middle">${transaction.date}</td>
                                            </tr>
                                        </c:forEach>
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
                                                    <form:input path="name" type="text" id="nameInput" name="catName"
                                                                class="form-control"/>
                                                </div>
                                            </div>
                                            <div class="form-group align-items-center">
                                                <div class='alert alert-warning text-center'
                                                     role='alert'></div>
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

<script>
    $('#editModal').on('show.bs.modal', function (event) {
        let button = $(event.relatedTarget)
        let categoryName = button.data('name');
        let categoryBudget = button.data('budget');
        let availableBudget = button.data('available');
        let modal = $(this)
        modal.find('#nameInput').val(categoryName);
        let budgetInput = modal.find('#budgetInput');
        budgetInput.val(categoryBudget);

        budgetInput.attr({
            "max": availableBudget
        });
        modal.find(".alert-warning").text(availableBudget + " € Available");
    })
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