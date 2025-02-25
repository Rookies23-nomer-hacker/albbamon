<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .board-header h2 {
            margin: 0;
            color: #333;
        }
        .board-header button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        .search-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }
        .search-bar select, .search-bar input {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-bar button {
            padding: 5px 10px;
            background-color: #ff4500;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .search-bar button:hover {
            background-color: #e03d00;
        }
        .notice {
            background-color: #fff5f5;
            padding: 10px;
            border: 1px solid #ffcccc;
            border-radius: 5px;
            margin-bottom: 10px;
        }
        .notice strong {
            color: #ff0000;
            margin-right: 5px;
        }
        .post-list {
            list-style: none;
            padding: 0;
        }
        .post-item {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .post-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
        }
        .post-title:hover {
            text-decoration: underline;
        }
        .post-meta {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
        .no-posts {
            text-align: center;
            padding: 50px 0;
            color: #888;
        }
        .footer-wrapper {
            width: 100%;
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            margin-top: auto;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <div class="container">
        <!-- 헤더 영역 -->
        <div class="board-header" style="margin-top: 30px;">
            <h2>알바경험담</h2>
            <c:choose>
                <%-- 로그인한 사용자에게만 글쓰기 버튼 표시 --%>
                <c:when test="${isLoggedIn}">
                    <button onclick="location.href='/api/post/write'">글쓰기</button>
                </c:when>
                <c:otherwise>
                    <button onclick="alert('로그인이 필요합니다.'); location.href='/api/user/sign-in';">글쓰기</button>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 검색 바 -->
        <div class="search-bar">
            <select>
                <option>작성일 순</option>
                <option>조회수 순</option>
            </select>
            <input type="text" placeholder="제목+본문 검색">
            <button>검색</button>
        </div>

        <!-- 공지사항 -->
        <div class="notice">
            <p><strong>공지</strong> 의심되면 멈추세요! 보이스피싱 범죄에 연루될 수 있습니다.</p>
        </div>
        <div class="notice">
            <p><strong>공지</strong> 쇼핑몰 리뷰, 공동 구매 알바 등 사기 수법에 주의하세요.</p>
        </div>

        <!-- 게시글 리스트 -->
        <ul class="post-list">
            <c:if test="${not empty posts}">
                <c:forEach var="post" items="${posts}" varStatus="status">
                    <li class="post-item">
                        <!-- 게시글 제목 -->
                        <a href="/api/post/${post.id}" class="post-title">${post.title}</a>

                        <!-- 게시글 내용 미리보기 (100자 제한) -->
                        <p>${fn:substring(post.contents, 0, 100)}...</p>

                        <!-- 작성자 및 작성일 표시 -->
                        <div class="post-meta">
                            작성자: ${post.userName} | 작성일: ${post.createDate}
                        </div>
                    </li>
                </c:forEach>
            </c:if>

            <!-- 게시글이 없을 때 메시지 표시 -->
            <c:if test="${empty posts}">
                <div class="no-posts">게시글이 없습니다.</div>
            </c:if>
        </ul>
    </div>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
