<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바몬</title>
    <link rel="stylesheet" href="style.css">
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

    .search-with-autocomplete__form {
        display: flex;
        align-items: center;
        border: 2px solid #ff4500;
        border-radius: 20px;
        padding: 5px 15px;
        width: 400px;
    }

    .search-with-autocomplete__form input {
        border: none;
        outline: none;
        font-size: 16px;
        padding: 5px;
        width: 100%;
    }

    .search-with-autocomplete__form button {
        background: none;
        border: none;
        cursor: pointer;
    }

    /* 네비게이션 메뉴 스타일 */
    .nav-container {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        width: 100%;
        max-width: 1400px;
        padding: 10px 30px;
    }

    /* 유저 정보 스타일 */
    .user-info {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .user-info button2 {
        padding: 8px 12px;
        border: 1px solid #ddd;
        background: #f3f3f3;
        cursor: pointer;
    }

    /* 메인 컨텐츠 스타일 */
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

    <main class="container2">
        <form id="writeForm" action="/api/post" method="POST" enctype="multipart/form-data">
            <h2>알바경험담 작성</h2>

            <!-- 제목 입력 -->
            <label for="title">제목</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력해 주세요." required>

            <!-- 내용 입력 -->
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" placeholder="내용을 입력하세요." required></textarea>

            <!-- 이미지 업로드 -->
            <label for="file">이미지 (선택)</label>
            <input type="file" id="file" name="file">

            <!-- 버튼 영역 -->
            <div class="buttons">
                <!-- 취소 버튼: 이전 페이지로 이동 -->
                <button type="button" onclick="window.history.back();">취소</button>
                <!-- 등록 버튼 -->
                <button type="submit">등록</button>
            </div>
        </form>
    </main>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
