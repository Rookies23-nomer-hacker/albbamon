<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("userName") %>님의 알바몬 회원정보</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
</head>
<body>
    <div class="container">
        <h2><%= request.getAttribute("name") %>님의 알바몬 회원정보</h2>
        <h3>회원 정보</h3>
        <div class="info-box">
            <p><strong>이름:</strong> <%= request.getAttribute("name") %></p>
            <p><strong>최근 수정일:</strong> <%= request.getAttribute("lastModifiedDate") %></p>
            <p><strong>연락처:</strong> <%= request.getAttribute("phone") %></p>
            <p><strong>이메일:</strong> <%= request.getAttribute("email") %></p>
            <button class="edit-btn">수정</button>
        </div>

        <h3>비밀번호 변경</h3>
        <div class="password-box">
            <p>비밀번호를 주기적으로 변경하여 소중한 개인정보를 안전하게 보호하세요. (6개월마다 알림)</p>
            <button class="edit-btn" onclick="location.href='/api/user/change-pw'">변경</button>
        </div>

        <h3>회원 탈퇴</h3>
        <div class="delete-box">
            <p>회원 탈퇴를 원하시면 아래 버튼을 클릭하세요.</p>
            <button class="delete-btn">탈퇴</button>
        </div>
    </div>
</body>
</html>
