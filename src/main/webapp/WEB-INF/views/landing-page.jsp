<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>

<html lang="en" class="bg-img-landing">
<head>
    <title>Landing Page</title>
    <jsp:include page="fragment/header.jsp"/>
</head>
<body>
<div>
    <jsp:include page="fragment/landing-top-bar.jsp"/>
</div>
<div class="bg-img-landing"></div>
<div>
    <jsp:include page="fragment/core-js-plugins.jsp"/>
</div>
</body>
</html>