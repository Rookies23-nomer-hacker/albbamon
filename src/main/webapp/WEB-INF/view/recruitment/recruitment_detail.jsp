<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 상세</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2 class="apply-title">채용 공고 상세</h2>
        <div class="apply-container">
        <div class="sub-label">
            <span class="section-margin-top2">모집 내용</span>
            </div>

            <div class="section-line"></div>

            <div class="apply-row">
            <span class="apply-label">공고 제목</span>
                <span class="apply-data">${recruitment.title}</span>
            </div>
            <div class="apply-row">
            <span class="apply-label">공고 내용</span>
                <span class="apply-data">${recruitment.contents}</span>
            </div>
            <div class="apply-row">
            <span class="apply-label">시급</span>
                <span class="apply-data">${recruitment.wage}</span>
            </div>
            <div class="apply-row">
            <span class="apply-label">공고 등록일</span>
                <span class="apply-data">${recruitment.createDate}</span>
            </div>
            <div class="apply-row">
            <span class="apply-label">마감 기한</span>
                <span class="apply-data">${recruitment.dueDate}</span>
            </div>
			<div class="apply-row">
                <c:if test="${recruitment.file != 'null'}">
                    <img src="${recruitment.file}" alt="이미지" class="img-fluid" style="max-width: 100%; height: auto;"/>
                </c:if>
			</div>
		
			
        </div>
				<c:if test="${empty sessionScope.ceoNum}">
					<button class="apply-btn" onclick="location.href='${contextPath}/recruitment/${recruitment.id}/apply-info'">지원하기</button>
				</c:if>
            
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>