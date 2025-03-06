<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>아이디 찾기 | 알빠몬</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- 커스텀 CSS -->
<link rel="stylesheet" href="${contextPath}/css/find_id/find-id.css">
<link rel="stylesheet" href="${contextPath}/css/find_id/common.css">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp"%>

<main class="custom-war">
<span class="custom-title">아이디 찾기</span>
    <div class="custom-container">
        <!-- 탭 메뉴 -->
        <div class="custom-tab-menu">
            <button id="personal-tab" class="custom-tab-btn active" onclick="showTab('PERSONAL')">개인회원</button>
            <button id="corporation-tab" class="custom-tab-btn" onclick="showTab('CORPORATION')">기업회원</button>
        </div>

        <!-- 아이디 찾기 폼 -->
        <form id="find-id-form" action="/find-id" method="GET">
            <!-- 개인회원 입력 폼 -->
            <div id="PERSONAL">
                <div class="custom-auth-methods">
                    <label class="custom-radio">
                        <input type="radio" name="find-method-personal" value="contact" checked> 연락처로 찾기
                    </label>
                </div>
                <div class="custom-text-box">
                	<span class="custom-text">회원정보에 등록된 연락처로 아이디를 찾을 수 있습니다.</span>
                
                </div>
                
                <div class="custom-input-group">
                    <div class="custom-input-group-box">
                        <span class="custom-input-group-text">이름</span>
                    </div>
                    <div class="custom-input-group-input">
                        <input type="text" id="name" name="name" placeholder="이름 입력">
                    </div>
                </div>
                
                <div class="custom-input-group">
                    <div class="custom-input-group-box">
                        <span class="custom-input-group-text">연락처</span>
                    </div>
                    <div class="custom-input-group-input">
                        <input type="text" id="phone" name="phone" placeholder="번호 입력">
                    </div>
                </div>
            </div>

            <!-- 기업회원 입력 폼 -->
            <div id="CORPORATION" style="display: none;">
                <div class="custom-auth-methods">
                    <label class="custom-radio">
                        <input type="radio" name="find-method-corporation" value="contact" checked> 사업자등록번호로 찾기
                    </label>
                </div>
                <div class="custom-text-box">
                	<span class="custom-text">회원정보에 등록된 사업자번호로 아이디를 찾을 수 있습니다.</span>
                
                </div>
                <div class="custom-input-group">
                    <div class="custom-input-group-box">
                        <span class="custom-input-group-text">가입자명</span>
                    </div>
                    <div class="custom-input-group-input">
                        <input type="text" id="name" name="name" placeholder="가입자명 입력">
                    </div>
                </div>
                <div class="custom-input-group">
                    <div class="custom-input-group-box">
                        <span class="custom-input-group-text">사업자등록번호</span>
                    </div>
                    <div class="custom-input-group-input">
                        <input type="text" id="ceoNum" name="ceoNum" placeholder="사업자등록번호 입력">
                    </div>
                </div>
            </div>

            <button type="submit" class="custom-btn">다음</button>
        </form>
    </div>
</main>

<%@ include file="/WEB-INF/view/common/footer.jsp"%>

<c:if test="${not empty errorMsg}">
    <script>
        alert("${errorMsg}");
        location.href = "/user/find-id";  // 다시 돌아갈 URL
    </script>
</c:if>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<!-- JS -->
<script>
    // 페이지 로드 시 기본 탭 설정
    document.addEventListener("DOMContentLoaded", function () {
        showTab("PERSONAL"); // 기본값은 개인회원 탭
    });

    // 탭 변경 함수
    function showTab(type) {
        if (type === "PERSONAL") {
            document.getElementById("PERSONAL").style.display = "block";
            document.getElementById("CORPORATION").style.display = "none";
            document.getElementById("personal-tab").classList.add("active");
            document.getElementById("corporation-tab").classList.remove("active");
        } else {
            document.getElementById("PERSONAL").style.display = "none";
            document.getElementById("CORPORATION").style.display = "block";
            document.getElementById("personal-tab").classList.remove("active");
            document.getElementById("corporation-tab").classList.add("active");
        }
    }

    document.getElementById("find-id-form").addEventListener("submit", function (event) {
        let selectedMethod;
        if (document.getElementById("PERSONAL").style.display === "block") {
            selectedMethod = document.querySelector("input[name='find-method-personal']:checked").value;
        } else {
            selectedMethod = document.querySelector("input[name='find-method-corporation']:checked").value;
        }

        let methodInput = document.createElement("input");
        methodInput.type = "hidden";
        methodInput.name = "find-method";
        methodInput.value = selectedMethod;
        this.appendChild(methodInput);
    });
</script>
</body>
</html>
