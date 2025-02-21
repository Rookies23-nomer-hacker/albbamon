<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <style>
        /* 헤더 스타일 */
        .header-wrapper {
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 120px; /* 헤더와 겹치지 않도록 설정 */
            padding-bottom: 40px; /* 푸터와 겹치지 않도록 설정 */
        }

        .join-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 900px;
            display: flex;
            flex-direction: column;
            border: 2px solid #ff6600;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            width: 100%;
        }

        .post-title {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }

        .post-meta {
            color: #999;
            font-size: 14px;
            margin-top: 5px;
        }

        .post-content {
            margin: 20px 0;
            font-size: 16px;
            line-height: 1.6;
            white-space: pre-wrap;
            width: 100%;
        }

        .post-menu {
            position: relative;
        }

        .menu-button {
            cursor: pointer;
            font-size: 24px;
            border: none;
            background: none;
        }

        .menu-options {
            display: none;
            position: absolute;
            right: 0;
            top: 30px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            z-index: 10;
        }

        .menu-options a {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
        }

        .menu-options a:hover {
            background-color: #f0f0f0;
        }

        /* 푸터 스타일 */
        .footer-wrapper {
            width: 100%;
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-top: auto;
            box-sizing: border-box;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            text-align: left;
        }
    </style>
    <script>
        function toggleMenu() {
            const menu = document.getElementById('menuOptions');
            menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
        }

        // 클릭 외부 영역 클릭 시 메뉴 닫기
        document.addEventListener('click', function(event) {
            const menu = document.getElementById('menuOptions');
            const button = document.getElementById('menuButton');
            if (!menu.contains(event.target) && !button.contains(event.target)) {
                menu.style.display = 'none';
            }
        });
    </script>
</head>
<body>
    <div class="header-wrapper">
        <%@ include file="/WEB-INF/view/common/header.jsp" %>
    </div>

    <div class="content-wrapper">
        <div class="join-container">
            <div class="post-header">
                <div>
                    <h1 class="post-title">
                        <c:out value="${post.title}" default="제목 없음"/>
                    </h1>
                    <div class="post-meta">
                        <c:out value="${post.userName}" default="익명"/> | <c:out value="${post.createDate}" default="날짜 없음"/>
                    </div>
                </div>
                <div class="post-menu">
                    <button id="menuButton" class="menu-button" onclick="toggleMenu()">⋯</button>
                    <div class="menu-options" id="menuOptions">
                        <a href="#">신고하기</a>
                        <a href="#">차단하기</a>
                    </div>
                </div>
            </div>
            <div class="post-content">
                <p><c:out value="${post.contents}" default="내용이 없습니다."/></p>
            </div>
        </div>
    </div>

<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
