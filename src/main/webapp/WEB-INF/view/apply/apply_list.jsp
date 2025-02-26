<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지원 현황</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2 class="title">지원 현황</h2>
        <div class="card">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th>지원일</th>
                    <th>기업명</th>
                    <th>공고 제목</th>
                    <th>시급</th>
                    <th>채용 결과</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="apply" items="${applyList}">
                        <tr>
                            <td>${apply.createDate}</td>
                            <td>${apply.company}</td>
                            <td>${apply.title}</td>
                            <td>${apply.wage}</td>
                            <td>${apply.status}</td>
                        </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>