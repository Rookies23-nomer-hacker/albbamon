<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 상세</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2>채용 공고 상세</h2>
        <div>
            <h3 class="section-margin-top2">모집 내용</h3>
            <div class="section-line"></div>
            <div class="section-text section-bold section-margin-top">공고 제목
                <div>${recruitment.title}</div>
            </div>
            <div class="section-text section-bold section-margin-top">공고 내용
                <div>${recruitment.contents}</div>
            </div>
            <div class="section-text section-bold section-margin-top">시급
                <div>${recruitment.wage}</div>
            </div>
            <div class="section-text section-bold section-margin-top">공고 등록일
                <div>${recruitment.createDate}</div>
            </div>
            <div class="section-text section-bold section-margin-top">마감 기한
                <div>${recruitment.dueDate}</div>
            </div>
        </div>
        <div class="button-container">
            <button class="btn-primary" onclick="location.href='/recruitment/${recruitment.id}/apply-info'">지원하기</button>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>