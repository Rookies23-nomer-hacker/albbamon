<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>albbamon 로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 450px;
            border: 2px solid #ff6600;
        }
        h1 {
            font-size: 28px;
            font-weight: bold;
            color: #ff6600;
            margin-bottom: 20px;
        }
        input {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
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
            margin-top: 10px;
        }
        .login-btn:hover {
            background-color: #e55a00;
        }
        .tab-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .tab {
            flex: 1;
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
        .links {
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }
        .links a {
            text-decoration: none;
            color: #666;
            margin: 0 10px;
        }
        .links a:hover {
            color: #ff6600;
        }
    </style>
    <script>let NotLogin = "${NotLogin}"; alert('로그인 해주세요.');</script>
</head>
<body>
    <div class="container">
        <h1>albbamon</h1>
        <div class="tab-container">
            <div class="tab active" id="personal-tab">개인회원</div>
            <div class="tab" id="business-tab">기업회원</div>
        </div>
        
<form action="/api/user/sign-in" method="post">
    <input type="hidden" name="userType" id="userType" value="personal">

    <div id="personal-form">
        <input type="text" placeholder="이메일" name="email" id="personal-email">
        <input type="password" placeholder="비밀번호" name="personal-password" id="personal-password">
    </div>

    <div id="business-form" style="display: none;">
        <input type="text" placeholder="기업 이메일" name="ceoemail" id="business-email">
        <input type="password" placeholder="기업 비밀번호" name="business-password" id="business-password">
    </div>

    <input type="hidden" name="password" id="final-password">
    <button type="submit" class="login-btn">로그인</button>
</form>

        <div class="links">
            <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a> | <a href="/api/user/join" style="color: #ff6600; font-weight: bold;">회원가입</a>
        </div>
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
        document.getElementById('personal-form').style.display = 'none';
        document.getElementById('business-form').style.display = 'block';
        document.getElementById('userType').value = "business";
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
