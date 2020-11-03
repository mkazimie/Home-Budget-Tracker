<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html>
<head>
    <title>Register</title>
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
                                <div class="col-lg-6 d-none d-lg-block bg-register-image"></div>
                                <div class="col-lg-6">
                                    <div class="p-5">
                                        <div class="text-center">
                                            <h1 class="h4 text-gray-900 mb-4">Create an Account</h1>
                                        </div>
                                        <div id="errorMsg" class="alert alert-danger d-none" role="alert">${error}</div>
                                        <form:form method="post" modelAttribute="userDto" cssClass="user">
                                            <div class="form-group">
                                                <form:input path="username" type="text"
                                                            class="form-control form-control-user"
                                                            placeholder="Username"/>
                                                <form:errors path="username" cssClass="errorMessage"/>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-sm-6 mb-3 mb-sm-0">
                                                    <form:input path="password" type="password"
                                                                class="form-control form-control-user"
                                                                placeholder="Password"/>
                                                    <form:errors path="password" cssClass="errorMessage"/>
                                                </div>
                                                <div class="col-sm-6">
                                                    <form:input path="matchingPassword" type="password"
                                                                class="form-control form-control-user"
                                                                placeholder="Repeat Password"/>
                                                </div>
                                            </div>
                                            <button class="btn btn-primary btn-user btn-block" type="submit"> Register
                                                Account
                                            </button>
                                        </form:form>
                                        <hr>
                                        <div class="text-center">
                                            <a class="small" href="/login">Already have an account? Login!</a>
                                        </div>
                                    </div>
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
<!-- Page level plugins -->
<script src="${pageContext.request.contextPath}/resources/static/js/customized-jQuery.js"></script>
</body>
</html>