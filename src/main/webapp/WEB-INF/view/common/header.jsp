<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Header</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Optional: For additional icon support (like Bootstrap icons) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<header class="p-3" style="background-color: #ff6600; color: white; width: 100%">
	<div class="container-fluid">
	    <div class="d-flex justify-content-between align-items-center">
	        <a href="/">
	            <!-- 이미지의 width와 height 속성 대신, max-width와 height를 auto로 설정하여 비율을 맞춤 -->
	            <img src="/img/albbamonlog.png" alt="Albbamon Logo" style="max-width: 100%; height: auto;">
	        </a>

	        <ul class="nav mb-2 justify-content-center mb-md-0">
	            <li><a href="/recruitment/list" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">채용공고</a></li>
	            <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">인재정보</a></li>
	            <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">QnA</a></li>
	            <li><a href="/api/post/" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">커뮤니티</a></li>
	            <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">지원자 이력서 확인</a></li>
	            <li><a href="/payment/payment" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">아이템 구매</a></li>
	        </ul>

	        <div class="d-flex">
	            <button type="button" class="btn btn-outline-light me-2" onclick="location.href='<%= request.getContextPath() %>/api/user/sign-in'">로그인</button>
	            <button type="button" class="btn btn-warning me-2" onclick="location.href='<%= request.getContextPath() %>/api/user'">회원가입</button>
	            <button type="button" class="btn me-2" style="background-color: white; color: black; border: 1px solid #ccc;" onclick="location.href='<%= request.getContextPath() %>/api/resume'">이력서 관리</button>
	            <button type="button" class="btn me-2" style="background-color: white; color: black; border: 1px solid #ccc;">공고 등록</button>
	        </div>
	    </div>
	</div>
</header>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
