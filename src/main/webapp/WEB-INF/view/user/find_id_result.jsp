<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>아이디 찾기 결과 | 알빠몬</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Custom CSS 파일 -->
    <link rel="stylesheet" href="/css/find_id/find-id-result.css">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <%@ include file="/WEB-INF/view/common/header.jsp"%>

    <main class="custom-war">
		<span class="custom-find-id-title">아이디 찾기</span>
		<div class="custom-container">
			<div class="custom-find-id-container">
                    <!-- 탭 메뉴 -->
                    <div class="custom-tab-menu">
                        <button id="personal-tab"
                            class="custom-tab-button ${activeTab eq 'per' ? 'active' : ''}"
                            onclick="location.href='${contextPath}/api/user/find-id'">개인회원</button>
                        <button id="corporation-tab"
                            class="custom-tab-button ${activeTab eq 'cor' ? 'active' : ''}"
                            onclick="location.href='${contextPath}/api/user/find-id'">기업회원</button>
                    </div>

                    <!-- 결과 메시지 -->
                    <p class="custom-result-message">
                        입력하신 정보와 일치하는 <span class="custom-id-color">아이디가 ${fn:length(emails)}개</span> 있습니다.
                    </p>
                    <p class="custom-info-text">
                        개인정보 도용에 따른 피해방지를 위해 일부는 *로 표시됩니다. <br> 회원가입 시 본인인증을 한 경우, 추가 본인인증을 통해 전체 아이디를 확인하실 수 있습니다.
                    </p>

                    <!-- 아이디 리스트 -->
                    <ul class="custom-id-list">
                        <c:forEach var="email" items="${emails}">
                            <li>${email}</li>
                        </c:forEach>
                    </ul>

                    <!-- 버튼 -->
                    <div class="custom-button-container">
                        <button class="custom-btn-secondary"
                            onclick="location.href='${contextPath}/api/user/find-pw'">비밀번호 찾기</button>
                        <button class="custom-btn-primary"
                            onclick="location.href='${contextPath}/api/user/sign-in'">로그인</button>
                    </div>
                </div>
            </div>
    </main>

    <%@ include file="/WEB-INF/view/common/footer.jsp"%>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
