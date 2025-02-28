<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>비밀번호 변경 | 알빠몬</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- CSS 파일 연결 -->
<link rel="stylesheet" href="${contextPath}/css/find_id/change-pw.css">
<link rel="stylesheet" href="${contextPath}/css/find_id/common.css">
<!-- jQuery 라이브러리 추가 (CDN 사용) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
        window.onload = function() {
            var errorMessage = "${error}";
            if (errorMessage && errorMessage !== "null") {
                alert(errorMessage);
                if (errorMessage === "비밀번호 변경 성공!") {
                    window.location.href = "${contextPath}/";
                } else {
                    window.location.href = "${contextPath}/api/user/change-pw";
                }
            }
        };
    </script>
</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp"%>
	<main class="custom-war">
		<span class="custom-title">비밀번호 변경</span>
		<div class="">
			<div class="custom-container">
						
			<form action="${contextPath}/change-pw" method="POST">
						<div id="contact-form">
						<div class="change-pw-box">
							<ul>
								<li><span class="change-pw-content">개인정보를 안전하게 보호하기 위해 비밀번호를 주기적(6개월)으로 변경해 주세요.</span></li>
								<li><span class="change-pw-content">비밀번호는 8~16자의 영문 대소문자,숫자,특수문자를 조합하여 사용할 수 있습니다.</span></li>
							</ul>
						</div>
						<div class="custom-change-pw-box">
							<div class="custom-input-group">
								<div class="custom-input-group-box">
									<span class="custom-input-group-text">현재 비밀번호</span>
								</div>
								<div class="custom-input-group-input">
									<input type="password" id="passwd" name="passwd"  >
								</div>
							</div>
							<div class="custom-input-group">
								<div class="custom-input-group-box">
									<span class="custom-input-group-text">새 비밀번호</span>
								</div>
								<div class="custom-input-group-input">
									<input type="password" id="newpasswd" name="newpasswd" >
								</div>
							</div>
							<div class="custom-input-group">
								<div class="custom-input-group-box">
									<span class="custom-input-group-text">새 비밀번호 확인</span>
								</div>
								<div class="custom-input-group-input">
									<input type="password" id="newpasswdcheck" name="newpasswdcheck" >
								</div>
							</div>
						</div>
					</div>
					<div class="btn-box">
						<button type="button" class="cancel" onclick="window.history.back();">취소</button>
						<button type="submit" class="submit-btn-pw">수정완료</button>
					</div>
				</form>				
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/view/common/footer.jsp"%>
	<!-- JS 파일 연결 -->
	<script src="/js/find_pw.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
