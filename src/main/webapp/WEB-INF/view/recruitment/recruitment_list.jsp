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
                    <th>기업명</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="recruitment" items="${recruitmentList}">
					    <c:if test="${recruitment.item == 'Y'}">
					        <tr onclick="location.href='/recruitment/list/${recruitment.id}';" class="blinking-text" style="cursor:pointer;">
                      			<td style="color: red;">★${recruitment.title}★</td>
					            <td style="color: red;">${recruitment.wage}</td>
					            <td style="color: red;">${recruitment.dueDate}</td>
					            <td style="color: red;">${recruitment.company}</td>
					        </tr>
					    </c:if>
					    <c:if test="${recruitment.item != 'Y'}">
					        <tr onclick="location.href='/recruitment/list/${recruitment.id}';" style="cursor:pointer;">
                      			<td>${recruitment.title}</td>
					            <td>${recruitment.wage}</td>
					            <td>${recruitment.dueDate}</td>
					            <td>${recruitment.company}</td>
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