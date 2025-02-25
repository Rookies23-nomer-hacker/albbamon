<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/style.css">
</head>

<style>
    /* 기본 스타일 초기화 */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: white;
        color: black;
    }

    .container2 {
        width: 80%;
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
    }

    h2 {
        margin-bottom: 20px;
    }

    label {
        display: block;
        margin-top: 10px;
        font-weight: bold;
    }

    input, textarea  {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ddd;
    }

    textarea {
        height: 150px;
    }

    .buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }

    .buttons button {
        width: 48%;
        background: #ff4500;
        color: white;
        border: none;
        cursor: pointer;
    }

    .file-info {
        margin-top: 5px;
        font-size: 0.9em;
        color: gray;
    }
</style>

<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <main class="container2">
        <!-- 수정된 폼: enctype 추가 및 action 경로 확인 -->
        <form id="editForm" action="${pageContext.request.contextPath}/api/post/update/${post.postId}" method="POST" enctype="multipart/form-data">
            <h2>게시글 수정</h2>

            <!-- 제목 -->
            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="${post.title}" placeholder="제목을 입력하세요." required>

            <!-- 내용 -->
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" placeholder="내용을 입력하세요." required>${post.contents}</textarea>

            <!-- 이미지 -->
            <label for="file">이미지 (선택)</label>
            <input type="file" id="file" name="file" multiple>
            <div class="file-info">
                <c:if test="${not empty post.file}">
                    기존 업로드된 파일: ${post.file}
                </c:if>
            </div>

            <!-- 버튼 -->
            <div class="buttons">
                <button type="button" onclick="window.history.back();">취소</button>
                <button type="submit">수정하기</button>
            </div>
        </form>
    </main>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
