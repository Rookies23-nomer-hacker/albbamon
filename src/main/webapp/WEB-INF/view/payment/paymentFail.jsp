<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 실패</title>
	<style>
        * {
            font-family: "Noto Sans KR", sans-serif;
        }
	    .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 80px; /* 헤더 높이만큼 여백 추가 */
            margin-bottom: 110px;
        }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
    <div class="container">
        <h2 class="mt-5">결제 실패!</h2>
        <p>결제를 다시 하세요.</p>
        <a href="${contextPath}/payment/payment" class="btn btn-primary">결제 페이지 이동</a>
    </div>
        <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
