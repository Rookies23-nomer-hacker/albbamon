<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 로그인</title>
    <c:if test="${not empty errorMessage}">
        <div style="color: red;">${errorMessage}</div>
    </c:if>
    <meta charset="UTF-8">
</head>
<body>
    <h2>관리자 로그인</h2>
    <form action="/sign-in" method="post">
        <label for="username">아이디:</label><br>
        <input type="text" id="username" name="identity" required><br><br>
        
        <label for="password">비밀번호:</label><br>
        <input type="password" id="password" name="password" required><br><br>
        
        <input type="submit" value="로그인">
    </form>
</body>
</html>
