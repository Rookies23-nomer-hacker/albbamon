<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 등록</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <form id="recruitmentForm" action="/api/recruitment", method="POST">
        <div class="recruitment-container">
            <h2>채용 공고 등록</h2>
            <div class="orange-form">
                <h3 class="section-margin-top2">모집 내용</h3>
                <div class="section-line"></div>
                <div class="section-text section-bold section-margin-top">공고 제목
                    <span class="section-head__required">*</span>
                    <input class="section-margin-left section-input-text" id="title" name="title" placeholder="공고 제목을 입력하세요"/>
                </div>
                <div class="section-text section-bold section-margin-top">공고 내용
                    <span class="section-head__required">*</span>
                    <textarea class="section-margin-left section-textarea" id="contents" name="contents" placeholder="공고 내용을 입력하세요"></textarea>
                </div>
                <div class="section-text section-bold section-margin-top">시급
                    <span class="section-head__required">*</span>
                    <input type="number" class="section-margin-left section-input-number" id="wage" name="wage" style="margin-left: 8%;"/>
                </div>
                <div class="section-text section-bold section-margin-top">마감 기한
                    <span class="section-head__required">*</span>
                    <input type="datetime-local" class="section-margin-left section-input-datetime-local" id="dueDate" name="dueDate"/>
                </div>
            </div>
            <div class="button-container">
                <button type="submit" class="save">
                    공고 저장
                </button>
            </div>
        </div>
    </form>
</main>
<script>
</script>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>