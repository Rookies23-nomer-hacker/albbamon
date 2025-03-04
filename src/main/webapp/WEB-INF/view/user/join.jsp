<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>albbamon 회원가입</title>
    <style>
        /* 헤더 스타일 */
        * {
            font-family: "Noto Sans KR", sans-serif;
        }
       .header-wrapper {
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
        }
/*         body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #ffffff;
            flex-direction: column;
            margin: 0;
            padding: 0;
        } */
        .main {
        	display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 0;
            }
        .join-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 900px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border: 2px solid #ff6600;
            margin-top: 80px; /* 헤더와 겹치지 않도록 설정 */
            margin-bottom: 50px;
            
        }
        .logo {
            width: 100%;
            padding: 10px 0;
            text-align: center;
            border-bottom: 2px;
            margin-bottom: 20px;
        }
        .logo h1 {
            font-size: 32px;
            font-weight: bold;
            color: #ff6600;
            margin: 0;
        }
        .sections {
            display: flex;
            justify-content: space-between;
            width: 100%;
        }
        .section {
            width: 48%;
            padding: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .section h2 {
            font-size: 22px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .section p {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .signup-btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .personal-btn {
            background-color: #ff6600;
            color: white;
        }
        .personal-btn:hover {
            background-color: #e55a00;
        }
        .business-btn {
            background-color: #333;
            color: white;
        }
        .business-btn:hover {
            background-color: #555;
        }
        .bottom-wrapper {
		width: 100%;
		}
    </style>
</head>
<body>
    <!-- 헤더 추가 -->
    <div class="header-wrapper">
        <%@ include file="/WEB-INF/view/common/header.jsp" %>
    </div>
    <div class="main">
    <div class="join-container">
        <div class="logo">
            <h1>albbamon</h1>
        </div>
        <div class="sections">
            <div class="section">
                <h2 style="color: #ff6600;">개인 회원</h2>
                <p>이력서를 등록하고 알바를 찾아보세요</p>
                <button class="signup-btn personal-btn" onclick="location.href='${contextPath}/api/user'">통합 개인 회원가입</button>
                <p style="font-size: 12px; color: #888; margin-top: 10px;"></p>
            </div>
            <div class="section">
                <h2 style="color: #333;">기업 회원</h2>
                <p>공고를 등록하고 인재를 찾아보세요</p>
                <button class="signup-btn business-btn" onclick="location.href='${contextPath}/api/user/ceo'">통합 기업 회원가입</button>
                <p style="font-size: 12px; color: #888; margin-top: 10px;">* 알바를 채용하시는 개인사업자, 사업체 직원 포함</p>
            </div>
        </div>
    </div>
    </div>
        <div class="bottom-wrapper">
    	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
    </div>
</body>
</html>