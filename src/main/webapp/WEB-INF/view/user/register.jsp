<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>통합 개인 회원가입</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8f8f8;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        width: 400px;
        background: #ffffff;
        padding: 30px;
        border-radius: 10px;
        border: 2px solid #ff6600;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h1 {
        font-size: 22px;
        text-align: left;
        margin-bottom: 20px;
    }

    label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    .required {
        color: red;
        margin-left: 3px;
    }

    input{
        width: 93%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f5f5f5;
    }

    input:focus {
        background-color: #ffffff;
        border: 1px solid #aaa;
    }

    .button-container {
        text-align: center;
    }

    button {
        width: 100%;
        padding: 12px;
        background-color: #ff6600;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        color: #FFFFFF;
        cursor: pointer;
    }
</style>
</head>
<body>

<div class="container">
    <h1>통합 개인 회원가입</h1>
    <form action="/api/user" method="post">
        <label for="phone">휴대폰번호<span class="required">*</span></label>
        <input type="text" id="userPhone" name="phone" placeholder="휴대폰 번호 ‘-’ 제외하고 입력" required>
        
        <label for="email">이메일<span class="required">*</span></label>
        <input type="email" id="userEmail" name="email" required>

        <label for="password">비밀번호<span class="required">*</span></label>
        <input type="password" id="userPw" name="password" required>

        <label for="name">이름<span class="required">*</span></label>
        <input type="text" id="userName" name="name" required>

        <div class="button-container" location.href="http://localhost:60083/api/user/sign-in">
            <button type="submit">가입하기</button>
        </div>
    </form>
</div>

</body>
<script>


</script>
</html>