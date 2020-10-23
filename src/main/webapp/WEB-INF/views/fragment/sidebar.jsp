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

<%--    <!-- Heading -->--%>
<%--    <div class="sidebar-heading">--%>
<%--        Interface--%>
<%--    </div>--%>

<%--    <!-- Nav Item - Pages Collapse Menu -->--%>
<%--&lt;%&ndash;    <li class="nav-item">&ndash;%&gt;--%>
<%--&lt;%&ndash;        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true"&ndash;%&gt;--%>
<%--&lt;%&ndash;           aria-controls="collapseTwo">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <i class="fas fa-fw fa-cog"></i>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <span>Components</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </a>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <div class="bg-white py-2 collapse-inner rounded">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <h6 class="collapse-header">Custom Components:</h6>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <a class="collapse-item" href="buttons.html">Buttons</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <a class="collapse-item" href="cards.html">Cards</a>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;    </li>&ndash;%&gt;--%>

<%--    <!-- Nav Item - Utilities Collapse Menu -->--%>
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"--%>
<%--           aria-expanded="true" aria-controls="collapseUtilities">--%>
<%--            <i class="fas fa-fw fa-wrench"></i>--%>
<%--            <span>Utilities</span>--%>
<%--        </a>--%>
<%--        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">--%>
<%--            <div class="bg-white py-2 collapse-inner rounded">--%>
<%--                <h6 class="collapse-header">Custom Utilities:</h6>--%>
<%--                <a class="collapse-item" href="utilities-color.html">Colors</a>--%>
<%--                <a class="collapse-item" href="utilities-border.html">Borders</a>--%>
<%--                <a class="collapse-item" href="utilities-animation.html">Animations</a>--%>
<%--                <a class="collapse-item" href="utilities-other.html">Other</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </li>--%>

<%--    <!-- Divider -->--%>
<%--    <hr class="sidebar-divider">--%>


<%--    <!-- Nav Item - Pages Collapse Menu -->--%>
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true"--%>
<%--           aria-controls="collapsePages">--%>
<%--            <i class="fas fa-fw fa-folder"></i>--%>
<%--            <span>Pages</span>--%>
<%--        </a>--%>
<%--        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">--%>
<%--            <div class="bg-white py-2 collapse-inner rounded">--%>
<%--                <h6 class="collapse-header">Login Screens:</h6>--%>
<%--                <a class="collapse-item" href="login.html">Login</a>--%>
<%--                <a class="collapse-item" href="register.html">Register</a>--%>
<%--                <a class="collapse-item" href="forgot-password.html">Forgot Password</a>--%>
<%--                <div class="collapse-divider"></div>--%>
<%--                <h6 class="collapse-header">Other Pages:</h6>--%>
<%--                <a class="collapse-item" href="404.html">404 Page</a>--%>
<%--                <a class="collapse-item" href="blank.html">Blank Page</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </li>--%>

<%--    <!-- Nav Item - MONEY TRANSFER -->--%>
<%--&lt;%&ndash;    <li class="nav-item">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <c:if test="${not empty budget.id}">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <a class="nav-link" href="/auth/budgets/${budget.id}/transfer">&ndash;%&gt;--%>
<%--&lt;%&ndash;        <i class="fas fa-money-bill-wave"></i>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <span>Transfer Money</span>&ndash;%&gt;--%>
<%--&lt;%&ndash;    </c:if>&ndash;%&gt;--%>
<%--&lt;%&ndash;    </li>&ndash;%&gt;--%>

<%--&lt;%&ndash;        <div class="h-100">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <a href="/auth/budgets/${budget.id}/transfer"&ndash;%&gt;--%>
<%--&lt;%&ndash;               class="btn btn-primary">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <i class="fas fa-money-bill-wave"></i>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <i class="fas fa-plus"></i></a>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>

<%--&lt;%&ndash;            <i class="fas fa-plus"></i></a>&ndash;%&gt;--%>
<%--&lt;%&ndash;                <span>Transfer</span></a>&ndash;%&gt;--%>

<%--    <!-- Nav Item - Charts -->--%>
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link" href="charts.html">--%>
<%--            <i class="fas fa-fw fa-chart-area"></i>--%>
<%--            <span>Charts</span></a>--%>
<%--    </li>--%>

<%--    <!-- Nav Item - Tables -->--%>
<%--    <li class="nav-item">--%>
<%--        <a class="nav-link" href="tables.html">--%>
<%--            <i class="fas fa-fw fa-table"></i>--%>
<%--            <span>Tables</span></a>--%>
<%--    </li>--%>

<%--    <!-- Divider -->--%>
<%--    <hr class="sidebar-divider d-none d-md-block">--%>

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>
<!-- End of Sidebar -->

</body>
</html>