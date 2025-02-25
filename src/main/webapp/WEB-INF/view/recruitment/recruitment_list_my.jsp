<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>나의 채용 공고</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
    <div class="recruitment-container">
        <h2 class="title">나의 채용 공고</h2>
        <div class="card">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th>제목</th>
                    <th>시급</th>
                    <th>마감 기한</th>
                    <th>지원서 목록</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="recruitment" items="${recruitmentList}">
                    <tr>
                        <td><a href="/recruitment/${recruitment.id}">${recruitment.title}</a></td>
                        <td>${recruitment.wage}</td>
                        <td>${recruitment.dueDate}</td>
                        <td><button class="btn-primary" onclick="location.href='/recruitment/${recruitment.id}/apply'">지원서 보기</button></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="button-container">
            <button class="btn-primary" onclick="location.href='/recruitment/write'">채용 공고 등록</button>
        </div>
    </div>
<div class="footer">
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</div>
</body>
</html>