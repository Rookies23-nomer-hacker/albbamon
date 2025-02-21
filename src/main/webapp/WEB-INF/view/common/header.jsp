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

<header class="p-3" style="background-color: #ff7f00; color: white;">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                <!-- You can replace the SVG with a logo or any other icon -->
                <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap">
                    <use xlink:href="#bootstrap"/>
                </svg>
                <span class="fs-4"  style="color: black; font-weight: bold;" onclick="location.href='<%=request.getContextPath()%>/main'">알빠몬(로고)</span>
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">채용정보</a></li>
                <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">인재정보</a></li>
                <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">QnA</a></li>
                <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">커뮤니티</a></li>
				<li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold;">지원자 이력서 확인</a></li>
            </ul>

            <div class="text-end">
                <button type="button" class="btn btn-outline-light me-2" onclick="location.href='<%= request.getContextPath() %>/api/user/sign-in'">로그인</button>
                <button type="button" class="btn btn-outline-light me-2" onclick="location.href='<%= request.getContextPath() %>/api/user/log-out'">로그아웃</button>
                <button type="button" class="btn btn-warning" onclick="location.href='<%= request.getContextPath() %>/api/user'">회원가입</button>
				<button type="button" class="btn" style="background-color: white; color: black; border: 1px solid #ccc;" onclick="location.href='<%= request.getContextPath() %>/api/resume'">이력서 관리</button>
				<button type="button" class="btn" style="background-color: white; color: black; border: 1px solid #ccc;" onclick="location.href='<%= request.getContextPath() %>/api/resume'">지원 현황</button>
				<button type="button" class="btn" style="background-color: white; color: black; border: 1px solid #ccc;">공고 등록</button>
            </div>
        </div>
    </div>
</header>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
