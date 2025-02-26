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
    <div class="recruitment-container">
        <h2>지원하기</h2>
        <div>
            <h3 class="section-margin-top2">지원 공고 확인</h3>
            <div class="section-line"></div>
            <div class="section-text section-bold section-margin-top">기업명
                <div>${recruitment.company}</div>
            </div>
            <div class="section-text section-bold section-margin-top">공고 제목
                <div>${recruitment.title}</div>
            </div>
            <div class="section-text section-bold section-margin-top">시급
                <div>${recruitment.wage}</div>
            </div>
        </div>
        <div>
            <h3 class="section-margin-top2">지원 정보 확인</h3>
            <div class="section-line"></div>
            <div class="section-text section-bold section-margin-top">이름
                <div>${user.name}</div>
            </div>
            <div class="section-text section-bold section-margin-top">이메일
                <div>${user.email}</div>
            </div>
            <div class="section-text section-bold section-margin-top">전화번호
                <div>${user.phone}</div>
            </div>
        </div>
        <div>
            <label class="terms-item">
                <input type="checkbox">
                <span class="bold-text">지원 정보를 확인하였습니다</span>
            </label>
        </div>
        <div class="button-container">
            <button class="btn-primary" onclick="location.href='/recruitment/${recruitment.id}/apply'">지원하기</button>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>