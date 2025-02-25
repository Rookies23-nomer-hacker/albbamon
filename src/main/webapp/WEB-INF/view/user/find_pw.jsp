<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>비밀번호 찾기 | 알빠몬</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- jQuery 라이브러리 추가 (CDN 사용) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/find_id/find-pw.css" rel="stylesheet">

</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp"%>
	<main class="custom-war">
		<span class="custom-title">비밀번호 찾기</span>
		<div class="custom-container">
			<div class="custom-find-id-container">
				<!-- 탭 메뉴 -->
				<div class="custom-tab-menu">
		            <button id="personal-tab" class="custom-tab-btn active" onclick="showTab('PERSONAL')">개인회원</button>
		            <button id="corporation-tab" class="custom-tab-btn" onclick="showTab('CORPORATION')">기업회원</button>
        		</div>
				
				<form id="find-pw-form" action="/find-pw" method="POST">
				<!-- 개인회원 입력 폼 -->
				<div id="PERSONAL">
					<!-- 인증 방법 선택 (연락처, 이메일, 본인인증 등) -->
					<div class="custom-auth-methods">
						<label class="custom-radio"> <input type="radio" name="find-method-personal" value="contact" checked>임시비밀번호 신청</label>
					</div>
					<div class="custom-text-box">
						<span class="custom-text">고객센터를 통해 본인확인 정보를 접수해 주시면, 고객센터
							확인 후 임시비밀번호를 발급해 드립니다.</span>
					</div>
					<div class="custom-input-group">
						<div class="custom-input-group-box">
							<span class="custom-input-group-text">아이디</span>
						</div>
						<div class="custom-input-group-input">
							<input type="text" id="name" name="name" placeholder="아이디 입력">
						</div>
					</div>
				</div>
				<!-- 기업회원 입력 폼 -->
				<div id="CORPORATION" style="display: none;">
					<!-- 인증 방법 선택 (연락처, 이메일, 본인인증 등) -->
					<div class="custom-auth-methods">
						<label class="custom-radio">
							<input type="radio" name="find-method-corporation" value="contact" checked>임시비밀번호 신청
						</label>
					</div>
					<div class="custom-text-box">
						<span class="custom-text">고객센터를 통해 본인확인 정보를 접수해 주시면, 고객센터
							확인 후 임시비밀번호를 발급해 드립니다.</span>
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
							<input type="text" id="ceoNum" name="ceoNum"
								placeholder="사업자등록번호 입력">
						</div>
					</div>	
				</div>
				<button type="submit" class="custom-btn">다음</button>
				</form>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/view/common/footer.jsp"%>
	<!-- JS 파일 연결 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js">
	</script>
	<script>
	// 페이지 로드 시 기본 탭 설정
    document.addEventListener("DOMContentLoaded", function () {
        showTab("PERSONAL"); // 기본값을 개인회원 탭으로 설정
    });

    // 탭 변경 함수 (ID를 정확히 인식하도록 수정)
    function showTab(type) {
        // 모든 탭 숨기기
        document.getElementById("PERSONAL").style.display = "none";
        document.getElementById("CORPORATION").style.display = "none";
        document.getElementById("personal-tab").classList.remove("active");
        document.getElementById("corporation-tab").classList.remove("active");

        // 선택한 탭 보이기
        document.getElementById(type).style.display = "block";
        if (type === "PERSONAL") {
            document.getElementById("personal-tab").classList.add("active");
        } else {
            document.getElementById("corporation-tab").classList.add("active");
        }
    }

    // 폼 제출 시 선택한 방식(hidden input으로 추가)
    document.getElementById("find-pw-form").addEventListener("submit", function (event) {
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
