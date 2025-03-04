<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 목록</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2 class="title" style="font-weight: bold;">채용 공고 목록</h2>
        <div class="card">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th style="width: 20%;">기업명</th>
                    <th style="width: 30%;">제목</th>
                    <th style="width: 20%;">시급</th>
                    <th style="width: 30%;">등록일</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="recruitment" items="${recruitmentList}">
					    <c:if test="${recruitment.item == 'Y'}">
					        <tr onclick="location.href='${contextPath}/recruitment/list/${recruitment.id}';" class="blinking-text" style="cursor:pointer;">
                                <td style="color: red; width: 20%;">${recruitment.company}</td>
                      			<td style="color: red; width: 30%;">★${recruitment.title}★</td>
					            <td style="color: red; width: 20%;">${recruitment.wage}</td>
					            <td style="color: red; width: 30%;">${recruitment.createDate}</td>
					        </tr>
					    </c:if>
					    <c:if test="${recruitment.item != 'Y'}">
					        <tr onclick="location.href='${contextPath}/recruitment/list/${recruitment.id}';" style="cursor:pointer;">
                                <td style="width: 20%;">${recruitment.company}</td>
                      			<td style="width: 30%;">${recruitment.title}</td>
					            <td style="width: 20%;">${recruitment.wage}</td>
                                <td style="width: 30%;">${recruitment.createDate}</td>
					        </tr>
					    </c:if>
					</c:forEach>
                </tbody>
            </table>
            <!-- 페이징 UI -->
			<div class="custom-pagination">
			    <c:if test="${not empty totalPages and totalPages > 1}">
			
			        <!-- 🔹 처음으로 버튼 -->
			        <c:if test="${currentPage > 1}">
			            <a href="?page=1&size=${pageSize}" class="custom-page-button">&laquo;</a>
			        </c:if>
			
			        <!-- 🔹 이전 그룹 이동 버튼 -->
			        <c:if test="${startPage > 1}">
			            <a href="?page=${startPage - 1}&size=${pageSize}" class="custom-page-button">&lt;</a>
			        </c:if>
			
			        <!-- 🔹 현재 그룹의 페이지 번호 (10개씩) -->
			        <c:forEach var="i" begin="${startPage}" end="${endPage}">
			            <a href="?page=${i}&size=${pageSize}"
			               class="custom-page-button ${i == currentPage ? 'active' : ''}">
			                ${i}
			            </a>
			        </c:forEach>
			
			        <!-- 🔹 다음 그룹 이동 버튼 -->
			        <c:if test="${endPage < totalPages}">
			            <a href="?page=${endPage + 1}&size=${pageSize}" class="custom-page-button">&gt;</a>
			        </c:if>
			
			        <!-- 🔹 끝으로 버튼 -->
			        <c:if test="${currentPage < totalPages}">
			            <a href="?page=${totalPages}&size=${pageSize}" class="custom-page-button">&raquo;</a>
			        </c:if>
			
			    </c:if>
			</div>

        </div>
        
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>