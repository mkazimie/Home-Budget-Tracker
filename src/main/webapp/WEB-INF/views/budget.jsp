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
                <%--                <div class="row col-2">--%>
                <div class="d-sm-flex align-items-baseline justify-content-between mb-4">
                    <a href="/auth/budgets" class="btn btn-primary"><i class="fas fa-angle-double-left"></i></a>
                    <a href="/auth/budgets/${budget.id}/transfer"
                       class="btn btn-primary">
                        <i class="fas fa-money-bill-wave"></i>&nbsp;&nbsp;<i class="fas fa-plus"></i></a>
                    <h1 class="col-10 h3 mb-0 text-gray-800">${budget.name} Budget Dashboard </h1>
                    <%--                    <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i--%>
                    <%--                            class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>--%>

                </div>


                <!-- Content Row -->
                <div class="row">

<%--                    <!-- TRANSFER MONEY -->--%>

<%--&lt;%&ndash;                    <div class="col-xl-3 col-md-6 mb-4 ">&ndash;%&gt;--%>
<%--                        <div class="card mb-4 shadow border-left-primary ml-3">--%>
<%--                            <div class="card-body">--%>
<%--                                <a href="/auth/budgets/${budget.id}/transfer"--%>
<%--                                   class="btn btn-primary">--%>
<%--                                    <i class="fas fa-money-bill-wave"></i>--%>
<%--                                    <i class="fas fa-plus"></i></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>

                        <!-- BUDGET -->
                        <div class="col-xl-3 col-md-6 mb-4 ">
                            <div class="card h-100 shadow py-2 bg-gradient-info ">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                Budget
                                            </div>
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


                        <%--                    </div>--%>


                        <%--                    <div class="h-100">--%>
                        <%--                        <a href="/auth/budgets/${budget.id}/transfer"--%>
                        <%--                           class="btn btn-primary">--%>
                        <%--                            <i class="fas fa-money-bill-wave"></i>--%>
                        <%--                            <i class="fas fa-plus"></i></a>--%>
                        <%--                    </div>--%>

                        <!-- AVAILABLE -->
                        <div class="col-xl-3 col-md-6 mb-4 ">
                            <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                            <div class="card h-100 shadow py-2 bg-gradient-success ">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                Available
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-white">${budget.moneyLeft} €</div>
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
                                                Spendings
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-white">${allExpenses} €</div>
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

                        <!-- Form for adding NEW CATEGORY -->
                        <div class="col-xl-4 col-md-6 mb-4 ">
                            <div class="card border-left-info shadow py-2">
                                <div class="card-header">
                                    <h5 class="card-title font-weight-bold text-center text-primary">Add
                                        Category</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center justify-content-center">
                                        <form:form method="post" action="/auth/budgets/${budget.id}/categories"
                                                   modelAttribute="categoryDto">

                                        <!-- Category Name SELECT Input - can be toggled -->

                                        <div id="selectInput" class="form-group">
                                            <form:label path="selectedName" cssClass="text-primary"> Name </form:label>
                                            <form:select path="selectedName" class="form-control" id="selectCat">
                                                <form:option label="--Select--"
                                                             selected="selected" value=" "/>
                                                <form:options items="${catName.keySet()}"/>
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
                                                            pattern="[A-Za-z0-9-_/ .,]{1,20}"/>
                                                <form:errors path="ownName" cssClass="errorMessage"/>
                                            </div>
                                        </div>

                                            <%--                                        <script>
                                                $("#select1").change(function () {
                                                        $("#selectCategory").removeClass("d-none");
                                            =        }
                                                });

                                                $("#getCatList").change(function () {
                                                    if ($("#getCatList").is(':checked')) {
                                                        $("#selectInput").removeClass("d-none");
                                                        $("#ownInput").addClass("d-none");
                                                        this.checked = false;
                                                        $("#selectCat option:selected").prop("selected", false);
                                                    }
                                                });


                                            </script>--%>

                                        <div class="form-group">
                                            <form:label path="categoryMoney"
                                                        cssClass="text-primary"> Budget </form:label>
                                            <div id="alert-available" class="alert alert-warning"
                                                 role="alert">${budget.budgetMoney -
                                                    allCategoryBudgets}€ Available
                                            </div>
                                            <div class="input-group">
                                                <form:input path="categoryMoney" type="number" min="1" step=".01"
                                                            max="${budget.budgetMoney - allCategoryBudgets}"
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
                                    <button class="btn btn-info btn-user btn-block" type="submit"> Save
                                    </button>
                                    </form:form>
                                </div>
                            </div>
                        </div>

                        <!-- Table displaying ALL CATEGORIES for this budget -->

                        <div class="col-xl-7 col-md-6 mb-4 ">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-header">
                                    <div class="row">
                                        <h5 class="m-0 font-weight-bold text-primary col-10 text-center"> Budget
                                            Categories </h5>
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
                                            </tr>
                                            </thead>

                                            <tbody>
                                            <c:forEach items="${budget.categories}" var="category">
                                                <tr>
                                                    <td class="align-middle"><a
                                                            href="/auth/budgets/${budget.id}/categories/${category.id}"
                                                            class="btn btn-primary"><i
                                                            class="fas fa-angle-double-right"></i></a></td>
                                                    <td
                                                            class="align-middle">
                                                        <c:choose>
                                                            <c:when test="${empty catName.get(category.name)}">
                                                                <i class="fas fa-ellipsis-h"></i> </c:when>
                                                            <c:otherwise>
                                                                ${catName.get(category.name)}
                                                            </c:otherwise>
                                                        </c:choose>
                                                        &nbsp;&nbsp; ${category.name}
                                                    </td>
                                                    <td class="align-middle">${category.categoryBudget} €</td>
                                                    <td class="align-middle text-success">${category.moneyLeft} €</td>
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
                                    <a target="_blank" rel="nofollow" href="https://undraw.co/">Browse Illustrations on
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
                                    <p>SB Admin 2 makes extensive use of Bootstrap 4 utility classes in order to reduce
                                        CSS
                                        bloat
                                        and poor page performance. Custom CSS classes are used to create custom
                                        components
                                        and
                                        custom utility classes.</p>
                                    <p class="mb-0">Before working with this theme, you should become familiar with the
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
        $("#selectCat").change(function () {
            if ($(this).val() === "customized") {
                $("#selectInput").addClass("d-none");
                $("#ownInput").removeClass("d-none");
            }
        });

        $("#getCatList").change(function () {
            if ($("#getCatList").is(':checked')) {
                $("#selectInput").removeClass("d-none");
                $("#ownInput").addClass("d-none");
                this.checked = false;
                $("#selectCat option:selected").prop("selected", false);
            }
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
