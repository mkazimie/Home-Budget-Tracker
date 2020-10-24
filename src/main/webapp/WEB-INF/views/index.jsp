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
    <jsp:include page="fragment/header.jsp"/>
</head>
<body>
<h1>Budgetary App</h1>
<h2><a href="/login"> Login </a></h2>
<h2><a href="/register"> Register </a></h2>
<div>
    <jsp:include page="fragment/core-js-plugins.jsp"/>
</div>
</body>
</html>