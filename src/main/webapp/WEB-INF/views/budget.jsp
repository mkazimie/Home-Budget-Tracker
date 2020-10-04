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
                    <h1 class="col-10 h3 mb-0 text-gray-800">${budget.name} Budget Dashboard </h1>
                    <%--                    <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i--%>
                    <%--                            class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>--%>
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
                                            <%--                                            ${catList[0].name}--%>
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-white">${budget.budgetMoney}</div>
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

                    <!-- Income -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <%--                    <div class="card border-left-primary h-100 shadow py-2">--%>
                        <div class="card h-100 shadow py-2 bg-gradient-info ">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                            Income
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


                    <!-- Card for adding Categories -->
                    <%--                    <div class="col-xl-3 col-md-6 mb-4 ">--%>
                    <%--                        <div class="card border-left-warning h-100 shadow py-2">--%>
                    <%--                            <div class="card-body">--%>
                    <%--                                <div class="row no-gutters align-items-center">--%>
                    <%--                                    <div class="col mr-2">--%>
                    <%--                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1"> NEW--%>
                    <%--                                            EXPENSE CATEGORY--%>
                    <%--                                        </div>--%>
                    <%--                                    </div>--%>
                    <%--                                    <div class="col-auto">--%>
                    <%--                                        <a href="/auth/budgets/${budget.id}/categories/form"--%>
                    <%--                                           class="btn btn-warning"><i class="fas fa-plus"></i></a>--%>
                    <%--                                    </div>--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>

                    <%--                    <!-- Card for adding new Transaction -->--%>
                    <%--                    <div class="col-xl-3 col-md-6 mb-4 ">--%>
                    <%--                        <div class="card border-left-info h-100 shadow py-2">--%>
                    <%--                            <div class="card-body">--%>
                    <%--                                <div class="row no-gutters align-items-center">--%>
                    <%--                                    <div class="col mr-2">--%>
                    <%--                                        <div class="text-md font-weight-bold text-primary text-uppercase mb-1"> NEW--%>
                    <%--                                            <br/>--%>
                    <%--                                            TRANSACTION--%>
                    <%--                                        </div>--%>
                    <%--                                    </div>--%>
                    <%--                                    <div class="col-auto">--%>
                    <%--                                        <a href="/auth/budgets/${budget.id}/transactions/form"--%>
                    <%--                                           class="btn btn-info"><i class="fas fa-plus"></i></a>--%>
                    <%--                                    </div>--%>
                    <%--                                </div>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>

                </div>

                <!-- Content Row -->
                <div class="row">

                    <!-- Form for adding NEW CATEGORY -->
                    <div class="col-xl-3 col-md-6 mb-4 ">
                        <div class="card border-left-warning shadow py-2">
                            <div class="card-header">
                                <h5 class="card-title font-weight-bold text-center text-primary">Add
                                    Category</h5>
                            </div>
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <form:form method="post" action="/auth/budgets/${budget.id}/categories"
                                               modelAttribute="categoryDto">
                                    <div class="form-group">
                                        <form:label path="name" cssClass="text-primary"> Name </form:label>
                                        <form:input path="name" type="text" class="form-control form-control-user"
                                                    placeholder="ex. Food, Home..." required="required"/>
                                        <form:errors path="name" cssClass="errorMessage"/>
                                    </div>
                                    <div class="form-group">
                                        <form:label path="categoryMoney" cssClass="text-primary"> Budget </form:label>
                                        <form:input path="categoryMoney" type="number" min="0"
                                                    max="${budget.budgetMoney}"
                                                    class="form-control form-control-user"
                                                    placeholder="ex. 100 €" required="required"/>
                                        <form:errors path="categoryMoney" cssClass="errorMessage"/>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <button class="btn btn-warning btn-user btn-block" type="submit"> Save
                                </button>
                                </form:form>
                            </div>
                        </div>
                    </div>

                    <!-- Table displaying ALL CATEGORIES for this budget -->
                    <div class="col-md-6 mb-4 ">
                        <div class="card border-left-primary shadow h-100 py-2">
                            <div class="card-header">
                                <div class="row">
                                    <h5 class="m-0 font-weight-bold text-primary col-10"> Budget Categories </h5>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                        <tr class="text-center">
                                            <th>Name</th>
                                            <th><strong>Budget €</strong></th>
                                            <th>Details</th>
                                        </tr>
                                        </thead>

                                        <tbody>
                                        <c:forEach items="${budget.categories}" var="category">
                                            <tr class="text-center">
                                                <td class="align-middle">${category.name}</td>
                                                <td class="align-middle">${category.categoryMoney}</td>
                                                <td class="align-middle"><a
                                                        href="/auth/budgets/${budget.id}/categories/${category.id}"
                                                        class="btn btn-primary"><i
                                                        class="fas fa-angle-double-right"></i></a></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%--                                                                                <c:forEach items="${budget.categories}" var="category">

                                                            <div class="col-xl-3 col-md-6 mb-4">
                                                                <div class="card border-bottom-primary shadow h-100 py-2">
                                                                    <div class="card-body">
                                                                        <div class="row no-gutters align-items-center">
                                                                            <div class="col mr-2">
                                                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">
                                                                                    ${category.name}
                                                                                </div>
                                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${category.categoryMoney}</div>
                                                                            </div>
                                                                            <div class="col-auto">
                                                                                <i class="fas fa-angle-double-right fa-2x text-gray-300"></i>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>--%>


                <!-- Form for adding NEW TRANSACTION directly LEAVE FOR CATEGORIES!!! -->
                <%--                    <div class="col-xl-3 col-md-6 mb-4 ">--%>
                <%--                        <div class="card border-left-info h-100 shadow py-2">--%>
                <%--                            <div class="card-header">--%>
                <%--                                <div class="card-title font-weight-bold text-center">Add Transaction</div>--%>
                <%--                            </div>--%>
                <%--                            <div class="card-body">--%>
                <%--                                <div class="row no-gutters align-items-center">--%>
                <%--                                    <form:form method="post" action="/auth/budgets/${budget.id}/transactions"--%>
                <%--                                               modelAttribute="transaction">--%>
                <%--                                    <div class="form-group">--%>
                <%--                                        <form:label path="title"> Title </form:label>--%>
                <%--                                        <form:input path="title" type="text" class="form-control form-control-user"--%>
                <%--                                                    placeholder="Transaction Title"/>--%>
                <%--                                        <form:errors path="title" cssClass="errorMessage"/>--%>
                <%--                                    </div>--%>
                <%--                                    <div class="form-group">--%>
                <%--                                        <form:label path="type"> Type </form:label>--%>
                <%--                                        <form:input path="type" type="text"--%>
                <%--                                                    class="form-control form-control-user"--%>
                <%--                                                    placeholder="Income / Spending "/>--%>
                <%--                                        <form:errors path="type" cssClass="errorMessage"/>--%>
                <%--                                    </div>--%>
                <%--                                    <div class="form-group">--%>
                <%--                                        <form:label path="date"> Date </form:label>--%>
                <%--                                        <form:input path="date" type="date"--%>
                <%--                                                    class="form-control form-control-user"--%>
                <%--                                                    placeholder="yyyy-MM-dd"/>--%>
                <%--                                        <form:errors path="date" cssClass="errorMessage"/>--%>
                <%--                                    </div>--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                            <div class="card-footer">--%>
                <%--                                <button class="btn btn-info btn-user btn-block" type="submit"> Save--%>
                <%--                                </button>--%>
                <%--                                </form:form>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>

                <%--                    MARK END OF ROW AN BEGINNING OF NEW ROW--%>
                <%--                </div>--%>


                <%--                <!-- Content Row -->--%>
                <%--                <div class="row">--%>
                <%--                    TILL HERE--%>

                <%--                    <!-- Earnings (Monthly) Card Example -->--%>
                <%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
                <%--                        <div class="card border-left-success shadow h-100 py-2">--%>
                <%--                            <div class="card-body">--%>
                <%--                                <div class="row no-gutters align-items-center">--%>
                <%--                                    <div class="col mr-2">--%>
                <%--                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Earnings--%>
                <%--                                            (Annual)--%>
                <%--                                        </div>--%>
                <%--                                        <div class="h5 mb-0 font-weight-bold text-gray-800">$215,000</div>--%>
                <%--                                    </div>--%>
                <%--                                    <div class="col-auto">--%>
                <%--                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>--%>
                <%--                                    </div>--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>

                <%--                    <!-- Earnings (Monthly) Card Example -->--%>
                <%--                    <div class="col-xl-3 col-md-6 mb-4">--%>
                <%--                        <div class="card border-left-info shadow h-100 py-2">--%>
                <%--                            <div class="card-body">--%>
                <%--                                <div class="row no-gutters align-items-center">--%>
                <%--                                    <div class="col mr-2">--%>
                <%--                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Tasks</div>--%>
                <%--                                        <div class="row no-gutters align-items-center">--%>
                <%--                                            <div class="col-auto">--%>
                <%--                                                <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>--%>
                <%--                                            </div>--%>
                <%--                                            <div class="col">--%>
                <%--                                                <div class="progress progress-sm mr-2">--%>
                <%--                                                    <div class="progress-bar bg-info" role="progressbar"--%>
                <%--                                                         style="width: 50%"--%>
                <%--                                                         aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>--%>
                <%--                                                </div>--%>
                <%--                                            </div>--%>
                <%--                                        </div>--%>
                <%--                                    </div>--%>
                <%--                                    <div class="col-auto">--%>
                <%--                                        <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>--%>
                <%--                                    </div>--%>
                <%--                                </div>--%>
                <%--                            </div>--%>
                <%--                        </div>--%>
                <%--                    </div>--%>

                <!-- CATEGORY CARD -->
                <%--                                                            <c:forEach items="${budget.categories}" var="category">--%>

                <%--                                            <div class="col-xl-3 col-md-6 mb-4">--%>
                <%--                                                <div class="card border-bottom-primary shadow h-100 py-2">--%>
                <%--                                                    <div class="card-body">--%>
                <%--                                                        <div class="row no-gutters align-items-center">--%>
                <%--                                                            <div class="col mr-2">--%>
                <%--                                                                <div class="text-md font-weight-bold text-primary text-uppercase mb-1">--%>
                <%--                                                                    ${category.name}--%>
                <%--                                                                </div>--%>
                <%--                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${category.categoryMoney}</div>--%>
                <%--                                                            </div>--%>
                <%--                                                            <div class="col-auto">--%>
                <%--                                                                <i class="fas fa-angle-double-right fa-2x text-gray-300"></i>--%>
                <%--                                                            </div>--%>
                <%--                                                        </div>--%>
                <%--                                                    </div>--%>
                <%--                                                </div>--%>
                <%--                                            </div>--%>
                <%--                                        </c:forEach>--%>
                <%--                                    </div>--%>

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
