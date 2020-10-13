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
                    <a href="/auth/budgets" class="btn btn-primary"><i class="fas fa-angle-double-left"></i></a>
                    <h1 class="col-10 h3 mb-0 text-primary font-weight-bolder">${budget.name} Budget Dashboard </h1>
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
                                            My Budget
                                        </div>
                                        <%--                                        <div class="h5 mb-0 font-weight-bold text-white">${allCategoryBudgets} €--%>
                                        <div class="h5 mb-0 font-weight-bold text-white">${budget.budgetMoney} €
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
                        <c:choose>
                        <c:when test="${budget.moneyLeft <= 0}">
                        <div class="card h-100 shadow py-2 bg-gradient-danger ">
                            </c:when>
                            <c:when test="${budget.moneyLeft <= 5}">
                            <div class="card h-100 shadow py-2 bg-gradient-warning ">
                                </c:when>
                                <c:otherwise>
                                <div class="card h-100 shadow py-2 bg-gradient-success ">
                                    </c:otherwise>
                                    </c:choose>
                                    <%--                        <div class="card h-100 shadow py-2 bg-gradient-success ">--%>
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                    Current Balance
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold
                                                        text-white">${budget.moneyLeft} €
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-hand-holding-usd fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- EXPENSES -->
                            <div class="col-xl-3 col-md-6 mb-4 ">
                                <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                                <div class="card h-100 shadow py-2 border-left-warning ">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                    All Expenses
                                                </div>
                                                <div class="h5 mb-0 font-weight-bold text-warning">${allExpenses}
                                                    €
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

                            <!-- Go To Categories -->
                            <div class="col-xl-4 col-md-6 mb-4">
                                <div class="card border-left-primary shadow">
                                    <div class="card-header bg-primary">
                                        <h5 class="card-title text-white font-weight-bold text-center"> Categories
                                        </h5>
                                        <div class="text-center">${budget.categories.size()} categories in this budget
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center justify-content-center">
                                            <a href="/auth/budgets/${budget.id}/categories"
                                               class="btn-success btn-circle btn-lg">
                                                <i class="fas fa-angle-double-right text-gray-100"></i>
                                            </a>

                                            <!-- Pie Chart -->
                                            <div class="chart-pie pt-4 pb-2">
                                                <canvas id="myPieChart"></canvas>
                                            </div>
                                            <div class="mt-4 text-center small">
                                                <span class="mr-2"><i
                                                        class="fas fa-circle text-primary"></i> Direct</span>
                                                <span class="mr-2"><i
                                                        class="fas fa-circle text-success"></i> Social</span>
                                                <span class="mr-2"><i
                                                        class="fas fa-circle text-info"></i> Referral</span>
                                            </div>

                                            <%--                                    <c:if test="${budget.categories.size() > 0}">--%>
                                            <%--                                        <table>--%>
                                            <%--                                            <thead>--%>
                                            <%--                                            <tr>--%>
                                            <%--                                                <th> Name</th>--%>
                                            <%--                                                <th> Budget</th>--%>
                                            <%--                                                <th> Available</th>--%>
                                            <%--                                            </tr>--%>
                                            <%--                                            </thead>--%>
                                            <%--                                            <tbody>--%>
                                            <%--                                            <c:forEach items="${budget.categories}" var="category">--%>
                                            <%--                                                <tr>--%>
                                            <%--                                                    <td>${category.name}</td>--%>
                                            <%--                                                    <td>${category.budget}</td>--%>
                                            <%--                                                    <td>${category.moneyLeft}</td>--%>
                                            <%--                                                </tr>--%>
                                            <%--                                            </c:forEach>--%>
                                            <%--                                            </tbody>--%>
                                            <%--                                        </table>--%>
                                            <%--                                    </c:if>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--                    <!-- Form for adding NEW Budget TRANSACTION -->--%>
                            <%--                    <div class="col-xl-4 col-md-6 mb-4">--%>
                            <%--                        <div class="card border-left-warning shadow">--%>
                            <%--                            <div class="card-header bg-warning">--%>
                            <%--                                <h5 class="card-title text-white font-weight-bold text-center"> Deposit / Withdrawal--%>
                            <%--                                </h5>--%>
                            <%--                                <div class="text-center">Directly to / from your budget</div>--%>
                            <%--                            </div>--%>
                            <%--                            <div class="card-body">--%>
                            <%--                                <div class="row no-gutters align-items-center justify-content-center">--%>
                            <%--                                    <form:form method="post"--%>
                            <%--                                               action="/auth/budgets/${budget.id}"--%>
                            <%--                                               modelAttribute="transactionDto">--%>
                            <%--                                    <div class="form-group">--%>
                            <%--                                        <form:label path="title" cssClass="text-primary"> Title </form:label>--%>
                            <%--                                        <form:input path="title" type="text" class="form-control form-control-user"--%>
                            <%--                                                    placeholder="" required="required"/>--%>
                            <%--                                        <form:errors path="title" cssClass="errorMessage"/>--%>
                            <%--                                    </div>--%>
                            <%--                                    <div class="form-group">--%>
                            <%--                                        <form:label path="type" cssClass="text-primary"> Type </form:label>--%>
                            <%--                                        <form:select path="type" class="form-control">--%>
                            <%--                                            <form:option value=" " label="--Select--" selected="selected"/>--%>
                            <%--                                            <form:options items="${transactionType}"/>--%>
                            <%--                                        </form:select>--%>
                            <%--                                        <form:errors path="type" cssClass="errorMessage"/>--%>
                            <%--                                    </div>--%>


                            <%--                                    <div class="form-group">--%>
                            <%--                                        <form:label path="sum" cssClass="text-primary"> Sum </form:label>--%>
                            <%--                                        <div class="input-group">--%>
                            <%--                                            <form:input path="sum" type="number" min="1" step=".01"--%>
                            <%--                                                        class="form-control form-control-user"--%>
                            <%--                                                        placeholder=""/>--%>
                            <%--                                            <div class="input-group-append">--%>
                            <%--                                                <span class="input-group-text">€</span>--%>
                            <%--                                            </div>--%>
                            <%--                                        </div>--%>
                            <%--                                        <form:errors path="sum" cssClass="errorMessage"/>--%>
                            <%--                                    </div>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                            <%--                            <div class="card-footer">--%>
                            <%--                                <button class="btn btn-warning font-weight-bolder btn-user btn-block" type="submit">--%>
                            <%--                                    Save--%>
                            <%--                                </button>--%>
                            <%--                                <div class="mt-2 text-center">--%>
                            <%--                                    <a href="/auth/budgets/${budget.id}/categories"--%>
                            <%--                                       class="text-primary font-weight-light">--%>
                            <%--                                        Register a Category Expense--%>
                            <%--                                    </a>--%>
                            <%--                                </div>--%>

                            <%--                                </form:form>--%>
                            <%--                            </div>--%>
                            <%--                        </div>--%>
                            <%--                    </div>--%>


                            <!-- LIST of Latest BUDGET TRANSACTIONS -->
                            <div class="col-xl-8 col-md-6 mb-4 ">
                                <div class="card border-left-primary shadow h-100">
                                    <div class="card-header bg-primary">
                                        <h5 class="font-weight-bold text-white text-center col-12">
                                            Transactions </h5>
                                        <div class="text-center text-secondary">${budget.transactions.size()}
                                            transactions in
                                            this budget
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped" id="dataTable" width="100%"
                                                   cellspacing="0">
                                                <thead>
                                                <tr class="text-center">
                                                    <th> Registered</th>
                                                    <th> Title</th>
                                                    <th><strong> Sum </strong></th>
                                                    <th> Date</th>
                                                    <th> Category</th>
                                                    <th> Payee</th>
                                                    <th> Balance</th>

                                                </tr>
                                                </thead>


                                                <tbody>
                                                <c:forEach items="${budget.transactions}" var="transaction">
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
                                                                <td class="align-middle text-danger">
                                                                    <c:if test="${transaction.sum > 0}">
                                                                        -
                                                                    </c:if>
                                                                        ${transaction.sum}€
                                                                </td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td class="align-middle text-success">
                                                                    +${transaction.sum}€
                                                                </td>
                                                            </c:otherwise>
                                                        </c:choose>

                                                        <fmt:parseDate value="${ transaction.date }"
                                                                       pattern="yyyy-MM-dd"
                                                                       var="parsedDate" type="both"/>
                                                        <td class="align-middle">
                                                            <fmt:formatDate
                                                                    pattern="dd/MM/yyyy"
                                                                    value="${ parsedDate }"
                                                            />
                                                        </td>


                                                        <c:choose>
                                                            <c:when test="${not empty transaction.category}">
                                                                <td class="align-middle">${transaction.category.name}</td>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <td class="align-middle"> Main Budget</td>
                                                            </c:otherwise>
                                                        </c:choose>


                                                        <td class="align-middle">${transaction.user.username}</td>
                                                        <td
                                                                class="align-middle
                                                        text-secondary">${transaction.currentBalance}</td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="row">

                            <!-- Area Chart -->
                            <div class="col-xl-8 col-lg-7">
                                <div class="card shadow mb-4">

                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
                                        <div class="dropdown no-arrow">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                 aria-labelledby="dropdownMenuLink">
                                                <div class="dropdown-header">Dropdown Header:</div>
                                                <a class="dropdown-item" href="#">Action</a>
                                                <a class="dropdown-item" href="#">Another action</a>
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#">Something else here</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div class="chart-area">
                                            <canvas id="myAreaChart"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Pie Chart -->
                            <div class="col-xl-4 col-lg-5">
                                <div class="card shadow mb-4">
                                    <!-- Card Header - Dropdown -->
                                    <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                        <h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
                                        <div class="dropdown no-arrow">
                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                 aria-labelledby="dropdownMenuLink">
                                                <div class="dropdown-header">Dropdown Header:</div>
                                                <a class="dropdown-item" href="#">Action</a>
                                                <a class="dropdown-item" href="#">Another action</a>
                                                <div class="dropdown-divider"></div>
                                                <a class="dropdown-item" href="#">Something else here</a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Card Body -->
                                    <div class="card-body">
                                        <div class="chart-pie pt-4 pb-2">
                                            <canvas id="myPieChart"></canvas>
                                        </div>
                                        <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i class="fas fa-circle text-primary"></i> Direct
                    </span>
                                            <span class="mr-2">
                      <i class="fas fa-circle text-success"></i> Social
                    </span>
                                            <span class="mr-2">
                      <i class="fas fa-circle text-info"></i> Referral
                    </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Content Row -->
                        <div class="row">

                            <!-- Content Column -->
                            <div class="col-lg-6 mb-4">

                                <!-- Project Card Example -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Projects</h6>
                                    </div>
                                    <div class="card-body">
                                        <h4 class="small font-weight-bold">Server Migration <span
                                                class="float-right">20%</span>
                                        </h4>
                                        <div class="progress mb-4">
                                            <div class="progress-bar bg-danger" role="progressbar" style="width: 20%"
                                                 aria-valuenow="20"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <h4 class="small font-weight-bold">Sales Tracking <span
                                                class="float-right">40%</span>
                                        </h4>
                                        <div class="progress mb-4">
                                            <div class="progress-bar bg-warning" role="progressbar" style="width: 40%"
                                                 aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <h4 class="small font-weight-bold">Customer Database <span
                                                class="float-right">60%</span></h4>
                                        <div class="progress mb-4">
                                            <div class="progress-bar" role="progressbar" style="width: 60%"
                                                 aria-valuenow="60"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <h4 class="small font-weight-bold">Payout Details <span
                                                class="float-right">80%</span>
                                        </h4>
                                        <div class="progress mb-4">
                                            <div class="progress-bar bg-info" role="progressbar" style="width: 80%"
                                                 aria-valuenow="80"
                                                 aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        <h4 class="small font-weight-bold">Account Setup <span
                                                class="float-right">Complete!</span></h4>
                                        <div class="progress">
                                            <div class="progress-bar bg-success" role="progressbar" style="width: 100%"
                                                 aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Color System -->
                                <div class="row">
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-primary text-white shadow">
                                            <div class="card-body">
                                                Primary
                                                <div class="text-white-50 small">#4e73df</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-success text-white shadow">
                                            <div class="card-body">
                                                Success
                                                <div class="text-white-50 small">#1cc88a</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-info text-white shadow">
                                            <div class="card-body">
                                                Info
                                                <div class="text-white-50 small">#36b9cc</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-warning text-white shadow">
                                            <div class="card-body">
                                                Warning
                                                <div class="text-white-50 small">#f6c23e</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-danger text-white shadow">
                                            <div class="card-body">
                                                Danger
                                                <div class="text-white-50 small">#e74a3b</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-secondary text-white shadow">
                                            <div class="card-body">
                                                Secondary
                                                <div class="text-white-50 small">#858796</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-light text-black shadow">
                                            <div class="card-body">
                                                Light
                                                <div class="text-black-50 small">#f8f9fc</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-4">
                                        <div class="card bg-dark text-white shadow">
                                            <div class="card-body">
                                                Dark
                                                <div class="text-white-50 small">#5a5c69</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="col-lg-6 mb-4">

                                <!-- Illustrations -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Illustrations</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="text-center">
                                            <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
                                                 src="img/undraw_posting_photo.svg" alt="">
                                        </div>
                                        <p>Add some quality, svg illustrations to your project courtesy of <a
                                                target="_blank"
                                                rel="nofollow"
                                                href="https://undraw.co/">unDraw</a>,
                                            a constantly updated collection of beautiful svg images that you can use
                                            completely
                                            free and
                                            without attribution!</p>
                                        <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations
                                            on
                                            unDraw
                                            &rarr;</a>
                                    </div>
                                </div>

                                <!-- Approach -->
                                <div class="card shadow mb-4">
                                    <div class="card-header py-3">
                                        <h6 class="m-0 font-weight-bold text-primary">Development Approach</h6>
                                    </div>
                                    <div class="card-body">
                                        <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to
                                            reduce
                                            CSS
                                            bloat
                                            and poor page performance. Custom CSS classes are used to create custom
                                            components
                                            and
                                            custom utility classes.</p>
                                        <p class="mb-0">Before working with this theme, you should become familiar with
                                            the
                                            Bootstrap
                                            framework, especially the utility classes.</p>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <!-- /.container-fluid -->

                </div>
                <!-- End of Main Content -->
            </div>
        </div>


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

<script src="${pageContext.request.contextPath}/resources/static/vendor/chart.js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/customizedJquery.js"></script>


<!-- Page level custom scripts -->
<script src="${pageContext.request.contextPath}/resources/static/js/demo/chart-area-demo.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/demo/datatables-demo.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/demo/chart-pie-demo.js"></script>
</body>
</html>
