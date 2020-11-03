<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@600;900&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/4b9ba14b0f.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<c:url value="/resources/static/css/404-500-errors-styles.css"/>"/>
    <title>500 Server Error</title>
</head>
<body>
<div class="mainbox">
    <div class="err text-center">500</div>
    <div class="msg">Unfortunately,
        our server crashed. Apologies.
        <p>Let's go <a href="/auth/budgets/"><strong> home </strong></a> and try from there.</p></div>
</div>
</body>
</html>