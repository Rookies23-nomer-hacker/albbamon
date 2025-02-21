<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 목록</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2 class="title">채용 공고 목록</h2>
        <div class="card">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th>제목</th>
                    <th>시급</th>
                    <th>마감 기한</th>
                    <th>작성자</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="recruitment" items="${recruitmentList}">
					    <c:if test="${buyerIds.contains(recruitment.id)}">
					        <tr class="blinking-text" style="color: red;">
					            <td>★${recruitment.title}★</td>
					            <td>${recruitment.wage}</td>
					            <td>${recruitment.dueDate}</td>
					            <td>${recruitment.userName}</td>
					        </tr>
					    </c:if>
					    <c:if test="${!buyerIds.contains(recruitment.id)}">
					        <tr>
					            <td>${recruitment.title}</td>
					            <td>${recruitment.wage}</td>
					            <td>${recruitment.dueDate}</td>
					            <td>${recruitment.userName}</td>
					        </tr>
					    </c:if>
					</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>