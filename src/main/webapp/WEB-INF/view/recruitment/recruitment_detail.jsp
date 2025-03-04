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
    <div class="container" style="width: 60%;">
        <div class="board-header" style="margin-top: 50px;">
            <h3 style="font-weight: bold;">채용 상세 정보</h3>
        </div>
        <div class="apply-container">
            <div class="sub-label">
                <div class="apply-sub-container">
                    <div style="width: 70%">
                        <h4 class="section-margin-top2">${recruitment.title}</h4>
                        <span class="apply-data" style="color: black;">${recruitment.company}</span>
                    </div>
                    <div style="width: 30%; text-align: right">
                        <span class="apply-data-date">${recruitment.createDate} 등록</span>
                    </div>
                </div>
            </div>
            <div class="apply-row">
                <span class="apply-label">모집 내용</span>
                <p class="apply-data" style="line-height: 1.6; white-space: pre-wrap;"><c:out value="${recruitment.contents}" /></p>
            </div>
			<div class="apply-row">
                <c:if test="${recruitment.file != 'null'}">
                    <img src="${recruitment.file}" alt="이미지" class="img-fluid" style="max-width: 100%; height: auto;"/>
                </c:if>
			</div>
            <div class="apply-row">
                <span class="apply-label">모집 마감</span>
                <span class="apply-data">${recruitment.dueDate}</span>
            </div>
            <div class="apply-row">
                <span class="apply-label">시  급</span>
                <span class="apply-data">${recruitment.wage}원</span>
            </div>
			
        </div>
        <div style="display: flex; justify-content: center">
            <c:if test="${empty sessionScope.ceoNum}">
                <button class="apply-btn" onclick="location.href='${contextPath}/recruitment/${recruitment.id}/apply-info'">지원하기</button>
            </c:if>
        </div>
            
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>