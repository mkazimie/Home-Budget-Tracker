<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar static-top">
    <a class="sidebar-brand d-flex align-items-center justify-content-center text-lg" href="/">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-comment-dollar"></i>
        </div>
        <div class="sidebar-brand-text mx-3"> Budgetarian</div>
    </a>
    <ul class="nav nav-pills text-uppercase nav-fill">
        <c:choose>
            <c:when test="${empty currentUser}">
                <li class="nav-item">
                    <a class="nav-link" href="/register"><i class="far fa-id-card"></i>&nbsp; register
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/login"><i class="fas fa-sign-in-alt"></i>&nbsp; login
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item">
                    <a class="nav-link" href="/auth/budgets"> <i class="fas fa-home"></i>
                       &nbsp; user panel
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="modal" data-target="#logoutModal" href="#">
                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> Logout
                    </a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>
<div>
    <jsp:include page="modals/logout-modal.jsp"/>
</div>
<!-- End of Topbar -->
</body>
</html>