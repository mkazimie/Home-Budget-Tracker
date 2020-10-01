<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 30.09.2020
  Time: 19:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html>
<head>
    <title>Register</title>
    <%@include file="fragment/header.jsp" %>
</head>

<body class="bg-gradient-primary">

<div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
        <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
                <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                <div class="col-lg-7">
                    <div class="p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-4">Create an Account</h1>
                        </div>
                            <div id="errorMsg" class="alert alert-danger d-none" role="alert">${error}</div>
                        <form:form method="post" modelAttribute="userDto" cssClass="user">
                            <div class="form-group">
                                <form:input path="username" type="text" class="form-control form-control-user"
                                            placeholder="Username"/>
                                <form:errors path="username" cssClass="errorMessage"/>
                            </div>
                            <div class="form-group row">
                                <div class="col-sm-6 mb-3 mb-sm-0">
                                    <form:input path="password" type="password" class="form-control form-control-user"
                                                placeholder="Password"/>
                                    <form:errors path="password" cssClass="errorMessage"/>

                                </div>
                                <div class="col-sm-6">
                                    <form:input path="matchingPassword" type="password"
                                                class="form-control form-control-user"
                                                placeholder="Repeat Password"/>

                                </div>
                            </div>
                            <button class="btn btn-primary btn-user btn-block" type="submit"> Register Account</button>

                            <%--                            <hr>--%>
                            <%--                            <a href="index.html" class="btn btn-google btn-user btn-block">--%>
                            <%--                                <i class="fab fa-google fa-fw"></i> Register with Google--%>
                            <%--                            </a>--%>
                            <%--                            <a href="index.html" class="btn btn-facebook btn-user btn-block">--%>
                            <%--                                <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook--%>
                            <%--                            </a>--%>
                        </form:form>
                        <hr>
                        <%--                        <div class="text-center">--%>
                        <%--                            <a class="small" href="forgot-password.html">Forgot Password?</a>--%>
                        <%--                        </div>--%>
                        <div class="text-center">
                            <a class="small" href="/login">Already have an account? Login!</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div>
    <%@include file="fragment/core-js-plugins.jsp" %>
</div>
</body>
</html>
