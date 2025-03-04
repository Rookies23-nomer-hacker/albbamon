<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 정보</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
	<style>
		*{
			font-family: "Noto Sans KR", sans-serif;
		}
		.recruitment-table2 {
			width: 100%;
			border-collapse: collapse;
			margin: 20px 0 20px 0;
		}

		.recruitment-table2 th {
			color: black;
			font-size: 17px;
			font-weight: bolder;
			padding: 16px;
			text-align: center;
			border-top: 1px solid black;
			border-bottom: 1px solid black;
		}

		.recruitment-table2 td {
			padding: 20px;
			text-align: center;
			border-bottom: 1px solid #ddd;
		}
	</style>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
	<div class="container" style="width: 60%;">
		<div class="board-header" style="margin-top: 50px;">
			<h3 style="font-weight: bold;">지금 등록된 알바속보</h3>
		</div>
        <div class="custom-pagination">
            <table class="recruitment-table2">
                <thead>
                <tr>
                    <th style="width: 20%;">기업명</th>
                    <th style="width: 50%;">제목</th>
                    <th style="width: 10%;">시급</th>
                    <th style="width: 20%;">등록일</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="recruitment" items="${recruitmentList}">
					    <c:if test="${recruitment.item == 'Y'}">
					        <tr onclick="location.href='${contextPath}/recruitment/list/${recruitment.id}';" class="blinking-text" style="cursor:pointer;">
                                <td style="background-color: #fff8f6; color: #ff6600;">${recruitment.company}</td>
                      			<td style="background-color: #fff8f6; color: #ff6600;">★${recruitment.title}★</td>
					            <td style="background-color: #fff8f6; color: #ff6600;">${recruitment.wage}</td>
					            <td style="background-color: #fff8f6; color: #ff6600;">${recruitment.createDate}</td>
					        </tr>
					    </c:if>
					    <c:if test="${recruitment.item != 'Y'}">
					        <tr onclick="location.href='${contextPath}/recruitment/list/${recruitment.id}';" style="cursor:pointer;">
                                <td>${recruitment.company}</td>
                      			<td style="color: black; font-weight: normal;">${recruitment.title}</td>
					            <td>${recruitment.wage}원</td>
                                <td>${recruitment.createDate}</td>
					        </tr>
					    </c:if>
					</c:forEach>
                </tbody>
            </table>
            

        </div>
        <!-- 페이징 UI -->
		<div class="custom-pagination">
		    <c:if test="${not empty totalPages and totalPages > 1}">
		
		        <!--이전 그룹 이동 버튼 -->
		        <a href="?page=${prevGroupPage}&size=${pageSize}" class="custom-page-button ${startPage > 1 ? '' : 'disabled'}">&lt;&lt;</a>
		
		        <!--이전 페이지 버튼 -->
		        <a href="?page=${currentPage - 1}&size=${pageSize}" class="custom-page-button ${currentPage > 1 ? '' : 'disabled'}">&lt;</a>
		
		        <!--현재 그룹의 페이지 번호 (최대 10개만 표시) -->
		        <c:forEach var="i" begin="${startPage}" end="${endPage}">
		            <a href="?page=${i}&size=${pageSize}" class="custom-page-button ${i == currentPage ? 'active' : ''}">${i}</a>
		        </c:forEach>
		
		        <!--다음 페이지 버튼 -->
		        <a href="?page=${currentPage + 1}&size=${pageSize}" class="custom-page-button ${currentPage < totalPages ? '' : 'disabled'}">&gt;</a>
		
		        <!--다음 그룹 이동 버튼 -->
		        <a href="?page=${nextGroupPage}&size=${pageSize}" class="custom-page-button ${endPage < totalPages ? '' : 'disabled'}">&gt;&gt;</a>
		
		    </c:if>
		</div>

    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>