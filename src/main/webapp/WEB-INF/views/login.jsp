<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <title>Login</title>
    <jsp:include page="fragment/header.jsp"/>
</head>
<body class="bootstrap-overrides bg-gradient-dark">
<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
    <!-- Main Content -->
    <div id="content">
        <jsp:include page="fragment/landing-top-bar.jsp"/>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-10 col-lg-12 col-md-9">
                    <div class="card o-hidden border-0 shadow-lg my-5">
                        <div class="card-body p-0">
                            <div class="row">
                                <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                                <div class="col-lg-6">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                        </div>
                                        <div class="errorMsg alert alert-danger d-none" role="alert">${error}</div>
                                        <form class="user" method="post">
                                            <div class="form-group">
                                                <input type="text" class="form-control form-control-user"
                                                       id="username" name="username" aria-describedby="emailHelp"
                                                       placeholder="Username">
                                            </div>
                                            <div class="form-group">
                                                <input type="password" class="form-control form-control-user"
                                                       id="password" name="password" placeholder="Password">
                                            </div>
                                            <div class="form-group">
                                            </div>
                                            <button class="btn btn-primary btn-user btn-block" type="submit"> Login
                                            </button>
                                        </form>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="/register">Create an Account!</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <jsp:include page="fragment/core-js-plugins.jsp"/>
        </div>
        <script src="${pageContext.request.contextPath}/resources/static/js/customized-jQuery.js"></script>
</body>
</html>