<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
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

<header class="p-3" style="background-color: #FFFFFF; color: white;">
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center">
            <a href="/">
                <img src="/img/albbamonlog.png" alt="Albbamon Logo" style="max-width: 100%; height: auto;">
            </a>

            <ul class="nav mb-2 justify-content-center mb-md-0 d-flex flex-wrap">
                <li><a href="${contextPath}/recruitment/list" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: -100px;">채용공고</a></li>
                <li><a href="${contextPath}/api/post" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">커뮤니티</a></li>
                <li><a href="#" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">인재정보</a></li>
				<c:if test="${not empty sessionScope.ceoNum}">
				    <c:if test="${not empty sessionScope.email}">
                    <li><a href="${contextPath}/recruitment/write" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">공고 등록</a></li>
						<c:if test="${empty sessionScope.item}">
	                    	<li><a href="${contextPath}/payment/payment" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">아이템 구매</a></li>
	                	</c:if>
					</c:if>
				</c:if>
            </ul>

            <!-- 로그인된 상태에서 '로그인' 버튼 숨기고, '로그아웃' 버튼 표시 -->
            <div class="d-flex flex-column flex-md-row align-items-center">
                <c:if test="${empty sessionScope.email}">
                    <button type="button" class="btn btn-warning mb-2 mb-md-0" style="background-color: #FF6600; border-color: #FF6600; color: #FFFFFF; border-radius: 30px; font-size: 17px;" onclick="location.href='${contextPath}/api/user/sign-in'">로그인</button>
                    <button type="button" class="btn btn-dark ms-2" style="border-radius: 30px; font-size: 15px; font-size: 17px" onclick="location.href='${contextPath}/api/user/join'">회원가입</button>
                </c:if>

                <c:if test="${not empty sessionScope.email}"> 
                    <p class="mb-2 mb-md-0" style="color: #000000; font-size: 20px; font-weight: bold;">
                       ${fn:substringBefore(sessionScope.email, '@')}
                        <c:if test="${not empty sessionScope.ceoNum}">
							<c:if test="${sessionScope.item != 'Y'}">
							    <span style="font-size: 20px; font-weight: bold;">(CEO)</span>
							</c:if>
							<c:if test="${sessionScope.item == 'Y'}">
							    <span style="font-size: 20px; font-weight: bold;">(Premium)</span>
							</c:if>
                        </c:if>
                    </p>
                    
                    <button type="button" class="btn btn-warning ms-2" style=" background-color: #FF6600; color: #FFFFFF; border-radius: 30px; font-size: 15px;" onclick="location.href='${contextPath}/api/user/log-out'">로그아웃</button>
                    <button type="button" class="btn btn-dark ms-2" style="border-radius: 30px; font-size: 15px;" onclick="location.href='${contextPath}/api/resume'">이력서 관리</button>
					<button type="button" class="btn btn-light ms-2" style="border-radius: 30px; font-size: 15px;" onclick="location.href='${contextPath}/api/user/account'">회원 정보</button>
                </c:if>
            </div>
        </div>
    </div>
</header>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

</body>
</html>
