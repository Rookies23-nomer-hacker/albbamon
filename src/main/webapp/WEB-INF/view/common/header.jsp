<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

	        <ul class="nav mb-2 justify-content-center mb-md-0" style="margin-left: -150px;">
	            <li><a href="/recruitment/list" class="nav-link px-2 text-black" style="color: black; font-weight: bold; font-size: 20px;">채용공고</a></li>
	            <li><a href="/api/post" class="nav-link px-2 text-black" style="color: black; font-weight: bold; font-size: 20px;  margin-left: 55px;">커뮤니티</a></li>
	            <li><a href="#" class="nav-link px-2 text-black" style="color: black; font-weight: bold; font-size: 20px;  margin-left: 55px;">인재정보</a></li>
				<c:if test="${not empty sessionScope.email}">
	            	<li><a href="/payment/payment" class="nav-link px-2 text-black" style="color: black; font-weight: bold; font-size: 20px;  margin-left: 55px;">아이템 구매</a></li>
				</c:if>
	        </ul>

			
			    <!-- 로그인된 상태에서 '로그인' 버튼 숨기고, '로그아웃' 버튼 표시 -->
			    <c:if test="${empty sessionScope.email}">
			        <button type="button" style="background-color: #FF6600; /* 검은색 배경 */
    color: #FFFFFF; /* 흰색 글자 */
    border: 2px solid white; /* 흰색 테두리 */
    border-radius: 30px; /* 버튼을 둥글게 만듦 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    font-size: 15px; /* 글자 크기 */
    cursor: pointer; /* 마우스 오버 시 포인터 변경 */
    margin-right: -24%;
" onclick="location.href='<%= request.getContextPath() %>/api/user/sign-in'">로그인</button>
					<!-- 회원가입 버튼 -->
					<button type="button" style="background-color: #000000; /* 검은색 배경 */color: #FFFFFF; /* 흰색 글자 */border: 2px solid white; /* 흰색 테두리 */border-radius: 30px; /* 버튼을 둥글게 만듦 */padding: 10px 20px; /* 버튼 내부 여백 */font-size: 15px; /* 글자 크기 */cursor: pointer; /* 마우스 오버 시 포인터 변경 */
						" onclick="location.href='<%= request.getContextPath() %>api/user/join'">회원가입</button>
				</c:if>
			    
			    <c:if test="${not empty sessionScope.email}">
			        <!-- 로그인한 이메일 출력 -->
					<p style="margin-right: -12%; margin-top: 18px; font-size: 15px;">
					    ${sessionScope.email}님<%-- ${ceoNum}, ${sessionScope.ceoNum}, ${ceonum}, ${sessionScope.ceonum} --%>
					    <c:if test="${not empty sessionScope.ceoNum}">
					        <!-- ceo_num이 존재하면 '사장님'으로 구분 -->
					        <span>(사장님)</span>
							<button type="button" class="btn me-2" style="background-color: white; color: black; border: 1px solid #ccc;">공고 등록</button>
					    </c:if>
					</p>
			        <!-- 로그아웃 버튼 -->
			        <button type="button" style="  background-color: #FF6600;  color: #FFFFFF; /* 흰색 글자 */
    border: 2px solid white; /* 흰색 테두리 */
    border-radius: 30px; /* 버튼을 둥글게 만듦 */
    padding: 10px 20px; /* 버튼 내부 여백 */
    font-size: 15px; /* 글자 크기 */
    cursor: pointer; /* 마우스 오버 시 포인터 변경 */
    margin-right: -12%;
  " onclick="location.href='<%= request.getContextPath() %>/api/user/log-out'">로그아웃</button>
			    </c:if>
			    
			    <c:if test="${not empty sessionScope.email}">
			        <button type="button"style="background-color: #000000; /* 검은색 배경 */color: #FFFFFF; /* 흰색 글자 */border: 2px solid white; /* 흰색 테두리 */border-radius: 30px; /* 버튼을 둥글게 만듦 */padding: 10px 20px; /* 버튼 내부 여백 */font-size: 15px; /* 글자 크기 */cursor: pointer; /* 마우스 오버 시 포인터 변경 */
						" onclick="location.href='<%= request.getContextPath() %>/api/resume'">이력서 관리</button>
			    </c:if>
			

	    </div>
	</div>
</header>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>