<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>아이디 찾기</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- CSS 파일 연결 -->
<link rel="stylesheet" href="/css/find_id/find-id.css">
<link rel="stylesheet" href="/css/find_id/common.css">
<!-- jQuery 라이브러리 추가 (CDN 사용) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<div class="">
		<span class="find-id-title">아이디 찾기</span>
		<div class="find-id-container">

			<!-- 탭 메뉴 -->
			<div class="tab-menu">
				<button class="active">개인회원</button>
				<button>기업회원</button>
			</div>
			<!-- 개인회원 입력 폼 -->
			<div id="PERSONAL">
				<!-- <form action="/find-id" method="POST"> -->
					<!-- 인증 방법 선택 (연락처, 이메일, 본인인증 등) -->
					<div class="auth-methods">
						<label class="radio_label"><input type="radio"name="find-method" value="contact" checked><span class="radio_text">연락처로 찾기</span></label>
						<label class="radio_label"><input type="radio"name="find-method" value="email" ><span class="radio_text">이메일로 찾기</span></label>
					</div>
					
<form action="/find-id" method="GET">
					<div id="contact-form">
						<div class="text-box">
							<span class="text">회원정보에 등록된 연락처로 아이디를 찾을 수 있습니다.</span>
						</div>
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">이름</span></div>
							<div class="input-group-input">
								<input type="text" id="name" name="name" placeholder="이름 입력" >
							</div>
						</div>
	
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">연락처</span></div>
							<div class="phone-group">
								<select id="phone-type">
									<option>휴대폰</option>
									<option>유선전화</option>
								</select> 
								<div class="input-group-input">
									<input type="text" id="phone" name="phone" placeholder="번호 입력">
								</div>
							</div>
						</div>
					</div>
					<button type="submit" class="submit-btn">다음</button>
				</form>
					<form action="/find-id" method="POST">
					<div id="email-form">
						<div class="text-box">
							<span class="text">회원정보에 등록된 이메일로 아이디를 찾을 수 있습니다.</span>
						</div>
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">이름</span></div>
								<div class="input-group-input">
									<input type="text" id="name" name="name" placeholder="이름 입력" >
								</div>
							</div>
		
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">이메일</span></div>
							<div class="phone-group">
							<input type="text" id="phone" name="phone" >
							</div>
						</div>
					</div>
					
					<button type="submit" class="submit-btn">다음</button>
				</form>
			</div>
			<!-- 기업회원 입력 폼 -->
			<div id="CORPORATION">
				<form action="/find-id" method="GET">
					<!-- 인증 방법 선택 (연락처, 이메일, 본인인증 등) -->
					<div class="auth-methods">
						<label class="radio_label"><input type="radio"name="find-method" value="contact" checked><span class="radio_text">사업자등록번호로 찾기</span></label>
						<label class="radio_label"><input type="radio"name="find-method" value="email" ><span class="radio_text">이메일로 찾기</span></label>
					</div>
					

					<div id="contact-form">
						<div class="text-box">
							<span class="text">회원정보에 등록된 사업자번호로 아이디를 찾을 수 있습니다.</span>
						</div>
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">가입자명</span></div>
							<div class="input-group-input">
							<input type="text" id="name" name="name" placeholder="이름 입력" >
							</div>
						</div>
	
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">사업자등록번호</span></div>
							<div class="input-group-input">
							
							<input type="text" id="phone" name="phone" placeholder="번호 입력">
							</div>
						</div>
					</div>
					
					<div id="email-form">
						<div class="text-box">
							<span class="text">회원정보에 등록된 이메일로 아이디를 찾을 수 있습니다.</span>
						</div>
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">가입자명</span></div>
							<div class="input-group-input">
								<input type="text" id="name" name="name" placeholder="이름 입력" >
							</div>
							</div>
		
						<div class="input-group">
							<div class="input-group-box"><span class="input-group-text">이메일</span></div>
							<div class="phone-group">
							<input type="text" id="phone" name="phone" >
							</div>
						</div>
					</div>
					
					<button type="submit" class="submit-btn">다음</button>
				</form>
			</div>
		</div>
	</div>
	<!-- JS 파일 연결 -->
	<script src="/js/find_id.js"></script>

</body>
</html>
