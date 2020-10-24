<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 28.09.2020
  Time: 23:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sidebar</title>
</head>
<body id="page-top">
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-comment-dollar"></i>
        </div>
        <div class="sidebar-brand-text mx-3"> Budgetarian </div>
    </a>
    <!-- Divider -->
    <hr class="sidebar-divider my-0">
    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link"  href="/auth/budgets">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>All Budgets</span></a>
    </li>
    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="/auth/budgets" data-toggle="collapse" data-target="#collapseTwo"
           aria-expanded="true"
           aria-controls="collapseTwo">
            <i class="fas fa-angle-double-right"></i>
            <span> Go To Budget </span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">Your budgets:</h6>
                <c:forEach items="${budgets}" var="budget">
                    <a class="collapse-item" href="/auth/budgets/${budget.id}">${budget.name}</a>
                </c:forEach>
            </div>
        </div>
    </li>
    <!-- Divider -->
    <hr class="sidebar-divider">
    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->
</body>
</html>