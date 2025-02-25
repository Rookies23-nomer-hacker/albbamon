<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 수정</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <form id="recruitmentForm" action="/recruitment/${recruitment.id}/modify", method="POST">
        <div class="recruitment-container">
            <h2>채용 공고 수정</h2>
            <div>
                <h3 class="section-margin-top2">모집 내용</h3>
                <div class="section-line"></div>
                <div class="section-text section-bold section-margin-top">공고 제목
                    <span class="section-head__required">*</span>
                    <input class="section-margin-left section-input-text" id="title" name="title" value="${recruitment.title}" />
                </div>
                <div class="section-text section-bold section-margin-top">공고 내용
                    <span class="section-head__required">*</span>
                    <textarea class="section-margin-left section-textarea" id="contents" name="contents">${recruitment.contents}</textarea>
                </div>
                <div class="section-text section-bold section-margin-top">시급
                    <span class="section-head__required">*</span>
                    <input type="number" class="section-margin-left section-input-number" id="wage" name="wage" value="${recruitment.wage}" />
                </div>
                <div class="section-text section-bold section-margin-top">마감 기한
                    <span class="section-head__required">*</span>
                    <input type="datetime-local" class="section-margin-left section-input-datetime-local" id="dueDate" name="dueDate" value="${recruitment.dueDate}" />
                </div>
            </div>
            <div class="button-container">
                <button type="submit" class="save">
                    공고 수정 완료
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