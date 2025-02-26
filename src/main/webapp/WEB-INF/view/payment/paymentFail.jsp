<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패</title>
</head>
<body>
    <div class="container">
        <h2 class="mt-5">결제 실패!</h2>
        <p>결제를 다시 하세요.</p>
        <a href="${contextPath}/payment/payment" class="btn btn-primary">결제 페이지 이동</a>
    </div>
</body>
</html>
