<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("userName") %>님의 알바몬 회원정보</title>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/Info/userinfo.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp"%>
<c:if test="${not empty alertMessage}">
    <script>
        alert("${alertMessage}");
        window.location.href = `${contextPath}/`; // ✅ 메인 페이지로 이동
    </script>
</c:if>
<main class="custom-war">
<span class="custom-title"><%= request.getAttribute("name") %>님의<br>알바몬 회원정보</span>
    <div class="custom-container">
     
        <h3>회원 정보</h3>
        <div class="custom-info-box">
            <p><strong>이름:</strong> <%= request.getAttribute("name") %></p>
            <p><strong>최근 수정일:</strong> <%= request.getAttribute("lastModifiedDate") %></p>
            <p><strong>연락처:</strong> <%= request.getAttribute("phone") %></p>
            <p><strong>이메일:</strong> <%= request.getAttribute("email") %></p>
            <c:if test="${not empty sessionScope.ceoNum}">
            <p><strong>사업자등록번호:</strong> ${ sessionScope.ceoNum}</p>
            <p><strong>회사명:</strong> <%= request.getAttribute("company") %></p>
            </c:if>
            
            <button class="custom-edit-btn">수정</button>
        </div>

        <h3>비밀번호 변경</h3>
        <div class="custom-password-box">
            <p>비밀번호를 주기적으로 변경하여 소중한 개인정보를 안전하게 보호하세요. (6개월마다 알림)</p>
            <button class="custom-edit-btn" onclick="location.href='${contextPath}/api/user/change-pw'">변경</button>
        </div>

        <h3>회원 탈퇴</h3>
        <div class="custom-delete-box">
            <p>회원 탈퇴를 원하시면 아래 버튼을 클릭하세요.</p>
            <button class="custom-edit-btn" onclick="location.href='${contextPath}/api/user/withdraw'">탈퇴</button>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
