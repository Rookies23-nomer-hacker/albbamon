<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>   
<!DOCTYPE html>
<html>
<head>
	<script>
		window.onload = function() {
		    var successMessage = "${successMessage}";
		    if (successMessage && successMessage !== "null") {
		        alert(successMessage);
		    }
		};
	</script>
    <meta charset="UTF-8">
    <title>나의 채용 공고</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="container" style="width: 60%;">
        <div class="board-header" style="margin-top: 50px;">
            <h3 style="font-weight: bold;">내가 작성한 채용공고</h3>
        </div>
        <div class="custom-pagination">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th style="width: 45%;">제목</th>
                    <th style="width: 15%;">시급</th>
                    <th style="width: 20%;">마감 기한</th>
                    <th style="width: 20%;">지원서 목록</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="recruitment" items="${recruitmentList}">
                    <tr>
                        <td><a href="${contextPath}/recruitment/${recruitment.id}/modify">${recruitment.title}</a></td>
                        <td>${recruitment.wage}</td>
                        <td>${recruitment.dueDate}</td>
                        <td><button class="btn-primary" onclick="location.href='${contextPath}/recruitment/${recruitment.id}/apply-list'">지원서 보기</button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="button-container">
            <button class="btn-primary" onclick="location.href='${contextPath}/recruitment/write'">채용 공고 등록</button>
        </div>
    </div>
<div class="footer">
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</div>
</body>
</html>