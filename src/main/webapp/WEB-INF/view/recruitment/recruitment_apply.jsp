<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공고 지원하기</title>
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
                <h4 class="section-margin-top2" style="font-weight: bold">지원 공고 확인</h4>
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
                <h4 class="section-margin-top2" style="margin-top:80px; font-weight: bold">지원 정보 확인</h4>
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
            <div class="apply-checkbox">
                <input type="checkbox" id="confirm-check">
                <label for="confirm-check">&nbsp;지원 정보를 확인하였습니다</label>
            </div>
        </div>
        <div style="display: flex; justify-content: center">
            <button class="apply-btn" onclick="createApply(${recruitment.id})">지원하기</button>
        </div>
    </div>

</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>

<script>
    function createApply() {
        let resumeExists = ${resumeExists};
        let isApplied = ${isApplied};

        if(!resumeExists) {
            alert('작성된 이력서가 없습니다. 지원을 위해 이력서를 작성해주세요');
            location.href='/api/resume'
        } else if(isApplied) {
            alert('이미 지원이 완료된 공고입니다');
        } else {
            location.href="/recruitment/${recruitment.id}/apply";
        }
    }
</script>
</body>
</html>
