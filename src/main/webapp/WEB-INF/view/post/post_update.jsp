<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // 세션에서 로그인한 사용자 ID 가져오기
    String sessionUserId = (String) session.getAttribute("userId");
    // 게시글 작성자 ID (DB에서 불러온 값이라고 가정)
    String postAuthorId = request.getParameter("authorId");
    // 게시글 제목과 내용 가져오기
    String title = request.getParameter("title");
    String contents = request.getParameter("contents");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .post-title {
            font-size: 24px;
            font-weight: bold;
        }
        .post-meta {
            color: #999;
            font-size: 14px;
        }
        .post-content {
            margin: 20px 0;
            font-size: 16px;
            line-height: 1.6;
        }
        .post-menu {
            position: relative;
        }
        .menu-button {
            cursor: pointer;
            font-size: 24px;
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
    </style>
    <script>
        function toggleMenu() {
            const menu = document.getElementById('menuOptions');
            menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="post-header">
            <div>
                <div class="post-title"><%= title %></div>
                <div class="post-meta">작성자: <%= postAuthorId %></div>
            </div>
            <div class="post-menu">
                <div class="menu-button" onclick="toggleMenu()">⋯</div>
                <div class="menu-options" id="menuOptions">
                    <% if (sessionUserId != null && sessionUserId.equals(postAuthorId)) { %>
                        <a href="editPost.jsp?postId=<%= request.getParameter("postId") %>">수정하기</a>
                        <a href="deletePost.jsp?postId=<%= request.getParameter("postId") %>">삭제하기</a>
                    <% } else { %>
                        <a href="#">신고하기</a>
                        <a href="#">차단하기</a>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="post-content">
            <p><%= contents %></p>
        </div>
    </div>
</body>
</html>
