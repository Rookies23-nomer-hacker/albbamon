<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바몬</title>
</head>

<style>
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

    .nav-container {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        width: 100%;
        max-width: 1400px;
        padding: 10px 30px;
    }

    /* 주황색 테두리 스타일 */
    .container-wrapper {
        width: 80%;
        max-width: 800px;
        margin: 50px auto 10px;
        padding: 30px 20px;
        border: 2px solid #ff4500;
        border-radius: 10px;
        background-color: white;
        position: relative; /* 제목을 테두리 밖으로 빼기 위해 설정 */
    }

    /* 제목을 테두리 밖으로 이동 */
    .title-container {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: -10px;
        width: 80%;
        max-width: 800px;
        margin: 0 auto 10px;
        text-align: left;
    }

    /* 입력 폼 스타일 */
    .container2 {
        width: 100%;
        margin: 0 auto;
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

    <!-- 제목을 테두리 밖으로 배치 -->
    <div class="title-container">
        <h2>알바경험담 작성</h2>
    </div>

    <main class="container-wrapper">
        <div class="container2">
            <form id="writeForm" enctype="multipart/form-data">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" placeholder="제목을 입력해 주세요." required>

                <label for="contents">내용</label>
                <textarea id="contents" name="contents" placeholder="내용을 입력하세요." required></textarea>

                <label for="file">이미지 (선택)</label>
                <input type="file" id="file" name="file">
            </form>
        </div>
    </main>

    <!-- 버튼을 테두리 밖으로 배치 -->
    <div class="button-wrapper">
        <div class="buttons">
            <button type="button" onclick="window.history.back();">취소</button>
            <button type="submit" id="submit" data-user-id="${sessionScope.userid}">등록</button>
        </div>
    </div>

    <script>
        document.getElementById("writeForm").addEventListener("submit", function(event) {
            event.preventDefault();
            submitForm();
        });

        function submitForm() {
            var form = document.getElementById("writeForm");
            var apiBaseUrl = "${apiBaseUrl}";
            alert(apiBaseUrl);
            var formData = new FormData(form);
            var userId = document.getElementById('submit').getAttribute('data-user-id');
            formData.append("userId", userId);

            fetch(`${apiBaseUrl}/api/post/write`, {
                method: "POST",
                body: formData,
                credentials: "include"
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("서버 응답 오류");
                }
                return response.json();
            })
            .then(result => {
                console.log("✅ 게시글 등록 성공:", result);
                alert("게시글이 성공적으로 등록되었습니다!");
                window.location.href = `${contextPath}/api/post`;
            })
            .catch(error => {
                console.error("❌ 게시글 등록 실패:", error);
                alert("게시글 등록에 실패했습니다. 다시 시도해주세요.");
            });
        }
    </script>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
