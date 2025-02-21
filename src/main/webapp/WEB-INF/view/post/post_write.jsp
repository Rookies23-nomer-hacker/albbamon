<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알바몬</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function submitPost(event) {
            event.preventDefault(); // 기본 폼 제출 동작 방지
            
            var title = document.getElementById("title").value.trim();
            var contents = document.getElementById("contents").value.trim();

            // 제목과 내용이 비어 있으면 알림 표시 후 제출 취소
            if (title === "" || contents === "") {
                alert("제목과 내용을 작성해 주세요.");
                return;
            }

            // Form 데이터 생성
            var formData = new FormData();
            formData.append("title", title);
            formData.append("contents", contents);
            formData.append("file", document.getElementById("file").files[0]);

            // AJAX를 사용하여 `/api/post`로 데이터 전송 (POST 요청)
            fetch("/api/post", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    alert("글이 작성되었습니다.");
                    window.location.href = "/api/post"; // 글 작성 후 페이지 이동
                } else {
                    alert("글 작성에 실패했습니다.");
                }
            })
            .catch(error => {
                alert("오류가 발생했습니다.");
                console.error(error);
            });
        }

        function cancelPost() {
            window.location.href = "/api/post"; // 취소 버튼 클릭 시 /api/user로 이동
        }
    </script>
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
    	
    
    </style>
    

<body>
     <%@ include file="/WEB-INF/view/common/header.jsp" %>
    
    <main class="container2">
        <h2>알바경험담 작성</h2>
        <form action="" method="post">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력해 주세요.">
            
            <label for="contents">내용</label>
            <textarea id="contents" name="contents" placeholder="내용을 입력하세요."></textarea>
            
            <label for="image">이미지 (선택)</label>
            <input type="file" id="file" name="file" multiple>
            
            <div class="buttons">
                <button type="button">취소</button>
                <button type="submit">등록</button>
            </div>
        </form>
    </main>
    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
