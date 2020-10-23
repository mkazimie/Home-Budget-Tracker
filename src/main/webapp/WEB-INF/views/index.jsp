<%--
  Created by IntelliJ IDEA.
  User: magdalena
  Date: 30.09.2020
  Time: 19:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>


<html lang="en">

<head>
    <title> Landing Page </title>
    <%@include file="fragment/header.jsp" %>
</head>

<body>
<h1> BUDGETARY APP</h1>

<p><a href="/login"> Login </a></p>
<p><a href="/register"> Register </a></p>

<div>
    <%@include file="fragment/core-js-plugins.jsp" %>
</div>
</body>
</html>
