<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바경험담 수정</title>
    <link rel="stylesheet" href="${contextPath}/static/style.css">
</head>

<style>
    /* 기본 스타일 초기화 */
    * {
        font-family: "Noto Sans KR", sans-serif;
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: white;
        color: black;
    }

    /* 주황색 테두리 스타일 추가 */
    .container-wrapper {
        width: 80%;
        max-width: 800px;
        margin: 50px auto;
        padding: 30px 20px;
        border: 2px solid #ff4500;
        border-radius: 10px;
        background-color: white;
    }

    /* 제목을 테두리 시작점과 정렬 */
    .title-container {
        font-size: 24px;
        font-weight: bold;
        width: 80%;
        max-width: 800px;
        margin: 0 auto 10px;
        text-align: left;
    }

    label {
        display: block;
        margin-top: 10px;
        font-weight: bold;
    }

    input, textarea {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    textarea {
        height: 150px;
    }

    /* 버튼 부분 테두리에서 분리 */
    .button-wrapper {
        width: 80%;
        max-width: 800px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
    }

    .buttons {
        width: 100%;
        display: flex;
        justify-content: space-between;
    }

    .buttons button {
        width: 48%;
        background: #ff4500;
        color: white;
        border: none;
        cursor: pointer;
        padding: 10px;
        border-radius: 5px;
        font-size: 16px;
    }

    .buttons button:hover {
        background: #e03d00;
    }
</style>

<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <!-- 제목을 테두리 시작점과 정렬 -->
    <div class="title-container">
        <h2>게시글 수정</h2>
    </div>

    <!-- 주황색 테두리 추가 -->
    <main class="container-wrapper">
        <form id="editForm" action="${contextPath}/api/post/update/${post.postId}" method="POST">
            <!-- 유저 ID를 숨겨서 전송 -->
            <input type="hidden" id="userId" name="userId" value="${sessionScope.loggedInUserId}">

            <!-- 제목 -->
            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="${post.title}" placeholder="제목을 입력하세요." required>

            <!-- 내용 -->
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" placeholder="내용을 입력하세요." required>${post.contents}</textarea>
        </form>
    </main>

    <!-- 버튼을 테두리 밖으로 배치 -->
    <div class="button-wrapper">
        <div class="buttons">
            <button type="button" onclick="window.history.back();">취소</button>
            <button type="submit" id="updateSubmit">수정하기</button>
        </div>
    </div>

    <script>
        document.getElementById("updateSubmit").addEventListener("click", function() {
            document.getElementById("editForm").submit();
        });
    </script>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
