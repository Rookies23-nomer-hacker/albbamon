<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>albbamon 로그인</title>
    <style>
/* 헤더 스타일 */
* {
    font-family: "Noto Sans KR", sans-serif;
}
.header-wrapper {
    width: 100%;
    top: 0;
    left: 0;
    z-index: 1000;
}

/* 로그인 폼 컨테이너 */
.login-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 80px; /* 헤더 높이만큼 여백 추가 */
    margin-bottom: 110px;
}


/* 로그인 박스 (기존 디자인 유지) */
.login-box {
    width: 450px; /* 기존 디자인 크기로 조정 */
    background: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    border: 2px solid #ff6600;
}


        .logo {
            width: 100%;
            padding: 10px 0;
            text-align: center;
            border-bottom: 2px;
            margin-bottom: 20px;
        }
        .logo h1 {
            font-size: 32px;
            font-weight: bold;
            color: #ff6600;
            margin: 0;
        }


/* 탭 버튼 (개인회원 / 기업회원) */
.tab-container {
    display: flex;
    width: 100%;
    justify-content: center;
    margin-bottom: 20px;
}


.tab {
    width: 50%; /* 탭 버튼 크기 균등 분배 */
    padding: 12px;
    cursor: pointer;
    background: #f2f2f2;
    border-radius: 5px;
    text-align: center;
    font-size: 16px;
    font-weight: bold;
    color: #555;
}

.tab.active {
    background: #ff6600;
    color: white;
}

/* 입력 필드 */
input {
    width: 100%;
    padding: 12px;
    margin: 8px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    background-color: #f5f5f5;
}

/* 입력 칸 간격 조정 */
input:not(:last-child) {
    margin-bottom: 12px; /* 입력 칸 사이 여백 증가 */
}


/* 로그인 버튼 */
.login-btn {
    width: 100%;
    background-color: #ff6600;
    color: white;
    border: none;
    padding: 12px;
    border-radius: 5px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 15px;
}

.login-btn:hover {
    background-color: #e55a00;
}

/* 링크 스타일 */
.links {
    margin-top: 20px;
    font-size: 14px;
    color: #666;
    text-align: center;
}

.links a {
    text-decoration: none;
    color: #666;
    margin: 0 10px;
}

.links a:hover {
    color: #ff6600;
}
.bottom-wrapper {
	width: 100%;
	}

    </style>
    <script>
        window.onload = function() {
            var errorMessage = "${error}";
            if (errorMessage && errorMessage !== "null") {
                alert(errorMessage);
            }
        };
    </script>
    <script>let NotLogin = "${NotLogin}"; if(NotLogin==1){alert('로그인 해주세요.');}</script>
</head>
<body>

<!-- 헤더를 포함하는 부분 -->
    <div class="header-wrapper">
        <%@ include file="/WEB-INF/view/common/header.jsp" %>
    </div>

    <div class="login-container">
        <div class="login-box">
        <div class="logo">
            <h1>albbamon</h1>
            </div>
        <div class="tab-container">
            <div class="tab active" id="personal-tab">개인회원</div>
            <div class="tab" id="business-tab">기업회원</div>
        </div>
        
<form action="${contextPath}/user/sign-in" method="post">
    <input type="hidden" name="userType" id="userType" value="personal">

    <div id="personal-form">
        <input type="text" placeholder="이메일" name="email" id="personal-email">
        <input type="password" placeholder="비밀번호" name="personal-password" id="personal-password">
    </div>

<!--     <div id="business-form" style="display: none;">
        <input type="text" placeholder="기업 이메일" name="ceoemail" id="business-email">
        <input type="password" placeholder="기업 비밀번호" name="business-password" id="business-password">
    </div> -->

    <input type="hidden" name="password" id="final-password">
    <button type="submit" class="login-btn">로그인</button>
</form>

        <div class="links">
            <a href="${contextPath}/user/find-id">아이디 찾기</a> | <a href="${contextPath}/user/find-pw">비밀번호 찾기</a> | <a href="${contextPath}/user/join" style="color: #ff6600; font-weight: bold;">회원가입</a>
        </div>
    </div>
    </div>
    <div class="bottom-wrapper">
    	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
    </div>
    <script>
    document.getElementById('personal-tab').addEventListener('click', function() {
        document.getElementById('personal-tab').classList.add('active');
        document.getElementById('business-tab').classList.remove('active');
        document.getElementById('personal-form').style.display = 'block';
        document.getElementById('business-form').style.display = 'none';
        document.getElementById('userType').value = "personal";
    });

    document.getElementById('business-tab').addEventListener('click', function() {
        document.getElementById('business-tab').classList.add('active');
        document.getElementById('personal-tab').classList.remove('active');
        /* document.getElementById('personal-form').style.display = 'none';
        document.getElementById('business-form').style.display = 'block';
        document.getElementById('userType').value = "business"; */
    });

    document.querySelector("form").addEventListener("submit", function(event) {
        let userType = document.getElementById('userType').value;
        let passwordInput;
        
        if (userType === "personal") {
            passwordInput = document.getElementById("personal-password").value;
        } else {
            passwordInput = document.getElementById("business-password").value;
        }

        document.getElementById("final-password").value = passwordInput;
    });
    </script>
</body>
</html>
