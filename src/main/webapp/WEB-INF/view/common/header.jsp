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
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon">
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Optional: For additional icon support (like Bootstrap icons) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .user-status {
            font-size: 15px;
            font-weight: normal;
            color: #007bff;
            border: 1px solid #007bff;
            border-radius: 30px;
            margin-right: 10px;
            padding: 2px 10px 2px 10px;
        }
        .premium-status {
            font-size: 15px;
            font-weight: normal;
            color: #d1b502;
            border: 1px solid #d1b502;
            border-radius: 30px;
            margin-right: 10px;
            padding: 2px 10px 2px 10px;
        }
    </style>
</head>
<body>

<header class="" style="padding: 0.5rem !important;
    margin-top: 15px;
    margin-bottom: 15px;background-color: #FFFFFF; color: white;">
    <div class="container-fluid">
    <c:if test="${not empty sessionScope.adminId}">
    	<span style="color:black;">관리자로 접속 중</span>
    </c:if>
    
        <div class="d-flex justify-content-between align-items-center">
            <a href="/">
                <img src="/img/albbamonlog.png" alt="Albbamon Logo" style="max-width: 70%; height: auto;">
            </a>

            <ul class="nav mb-2 justify-content-center mb-md-0 d-flex flex-wrap">
                <li><a href="${contextPath}/recruitment" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: -100px;">채용정보</a></li>
                <li><a href="${contextPath}/post?page=1&size=10" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">알바토크</a></li>
                <li><a href="${contextPath}/resume/all" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">인재정보</a></li>
				<c:if test="${not empty sessionScope.ceoNum}">
				    <c:if test="${not empty sessionScope.email}">
                    <li><a href="${contextPath}/recruitment/write" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">공고 등록</a></li>
						<c:if test="${empty sessionScope.item}">
	                    	<li><a href="${contextPath}/payment" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">프리미엄 구매</a></li>
	                	</c:if>
					</c:if>
				</c:if>
				<c:if test="${empty sessionScope.ceoNum}">
					<c:if test="${not empty sessionScope.email}">
						<li><a href="${contextPath}/resume/write" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">이력서 작성</a></li>
					</c:if>
				</c:if>
				<li><a href="${contextPath}/notice" class="nav-link px-2 text-black" style="font-weight: bold; font-size: 20px; margin-left: 55px;">공지사항</a></li>
            </ul>

            <div class="d-flex flex-column flex-md-row align-items-center">
                <c:if test="${empty sessionScope.email and empty sessionScope.adminId}">
                    <button type="button" class="btn mb-2 mb-md-0" style="background-color: #FF6600; border-color: #FF6600 !important; stroke: #FF6600 !important; outline: none !important; color: #FFFFFF; border-radius: 10px; font-size: 17px;" onclick="location.href='${contextPath}/user/sign-in'">로그인</button>
                    <button type="button" class="btn btn-dark ms-2" style="border-radius: 10px; font-size: 15px; font-size: 17px" onclick="location.href='${contextPath}/user/join'">회원가입</button>
                </c:if>

                <c:if test="${not empty sessionScope.email}"> 
                    <p class="mb-2 mb-md-0" style="color: #000000; font-size: 20px; font-weight: bold; margin-right: 10px">
                        <c:if test="${empty sessionScope.ceoNum}">
                            <span class="user-status">개인</span>
                        </c:if>
                        <c:if test="${not empty sessionScope.ceoNum}">
                            <c:if test="${sessionScope.item != 'Y'}">
                                <span class="user-status">기업</span>
                            </c:if>
                            <c:if test="${sessionScope.item == 'Y'}">
                                <span class="premium-status">
                                    <img src="/img/crown.png" style="width: 20px; margin-bottom: 5px; margin-left: -7px; margin-right: 5px">
                                    프리미엄
                                </span>
                            </c:if>
                        </c:if>
                       <c:choose>
						  <c:when test="${not empty sessionScope.email}">
						    ${fn:substringBefore(sessionScope.email, '@')}님
						  </c:when>
						</c:choose>
                    </p>
                    
                    <button type="button" class="btn ms-2" style=" background-color: #FF6600; color: #FFFFFF; border-radius: 10px; font-size: 15px;" onclick="location.href='${contextPath}/user/log-out'">로그아웃</button>
                    <button type="button" class="btn btn-dark ms-2" style="border-radius: 10px; font-size: 15px;" onclick="location.href='${contextPath}/user/account'">마이 페이지</button>
                </c:if>
                <c:if test="${not empty sessionScope.adminId}">
                	<span style="color:black">관리자님</span>
                	<button type="button" class="btn ms-2" style=" background-color: #FF6600; color: #FFFFFF; border-radius: 10px; font-size: 15px;" onclick="location.href='${contextPath}/user/log-out'">로그아웃</button>
                </c:if>
            </div>
        </div>
    </div>
</header>

<!-- Bootstrap JS and Popper.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<div style="border-bottom: 3px solid #eee;">
</div>
</body>
</html>
