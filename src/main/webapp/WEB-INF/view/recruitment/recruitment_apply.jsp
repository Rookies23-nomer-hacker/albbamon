<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지원하기</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    
        <h2 class="apply-title">지원하기</h2>
		<div class="apply-container">
        <!-- 지원 공고 확인 -->
        <div class="sub-label">
        <span class="section-margin-top2">지원 공고 확인</span>
        </div>
        <div class="section-line"></div>

        <div class="apply-row">
            <span class="apply-label">기업명</span>
            <span class="apply-data">${recruitment.company}</span>
        </div>
        <div class="apply-row">
            <span class="apply-label">공고 제목</span>
            <span class="apply-data">${recruitment.title}</span>
        </div>
        <div class="apply-row">
            <span class="apply-label">시급</span>
            <span class="apply-data">${recruitment.wage}</span>
        </div>

        <!-- 지원 정보 확인 -->
        <div class="sub-label">
        <span class="section-margin-top2">지원 정보 확인</span>
        </div>
        <div class="section-line"></div>

        <div class="apply-row">
            <span class="apply-label">이름</span>
            <span class="apply-data">${user.name}</span>
        </div>
        <div class="apply-row">
            <span class="apply-label">이메일</span>
            <span class="apply-data">${user.email}</span>
        </div>
        <div class="apply-row">
            <span class="apply-label">전화번호</span>
            <span class="apply-data">${user.phone}</span>
        </div>
		    
        <!-- 체크박스 -->
        <div class="apply-checkbox">
            <input type="checkbox" id="confirm-check">
            <label for="confirm-check">&nbsp;지원 정보를 확인하였습니다</label>
        </div>
		</div>
        <!-- 지원하기 버튼 -->
        <button class="apply-btn" onclick="location.href='/recruitment/${recruitment.id}/apply'">지원하기</button>

</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
