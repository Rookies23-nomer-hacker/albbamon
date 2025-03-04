<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <title>알바경험담</title>
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
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .board-header h3 {
            margin: 0;
            color: #333;
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
            border-bottom: 3px solid #eee;
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
        /* 페이지네이션 스타일 */
		.custom-pagination-paging {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-top: 20px;
		    flex-wrap: wrap;
		}
		
		/* 기본 버튼 스타일 */
		.custom-page-button {
		    display: inline-block;
		    margin: 5px;
		    padding: 10px 15px;
		    text-decoration: none;
		    color: #333;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 5px;
		    font-size: 14px;
		    font-weight: bold;
		    min-width: 30px;
		    text-align: center;
		    transition: background-color 0.3s ease;
		}
		
		/* 버튼 호버 효과 */
		.custom-page-button:hover {
		    background-color: #f0f0f0;
		}
		
		/* 현재 페이지 (활성화) */
		.custom-page-button.active {
		    background-color: #ff6600;
		    color: white;
		    border: 1px solid #ff6600;
		}
		
		/* 비활성화 버튼 (숨김 처리) */
		.custom-page-button.disabled {
		    visibility: hidden; /* 🔹 버튼 크기를 유지하면서 숨김 */
		    pointer-events: none; /* 🔹 클릭 방지 */
		}

    </style>
</head>
<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <div class="container">
        <!-- 헤더 영역 -->
        <div class="board-header" style="margin-top: 30px;">
            <h3 style="font-weight: bold;">알바경험담</h3>
        </div>

        <!-- 검색 바 -->
        <div class="search-bar">
            <select>
                <option>작성일 순</option>
                <option>조회수 순</option>
            </select>
            <form action="${contextPath}/api/post/search" method="get">
                <input type="text" name="keyword" placeholder="검색어를 입력하세요">
                <button type="submit" style="background-color: #ff6600;">검색</button>
            </form>
            <c:choose>
                <c:when test="${isLoggedIn}">
                    <button onclick="location.href='${contextPath}/api/post/write'" style="background-color: #000000;">글쓰기</button>
                </c:when>
                <c:otherwise>
                    <button onclick="alert('로그인이 필요합니다.'); location.href='${contextPath}/api/user/sign-in';">글쓰기</button>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="custom-pagination">
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
                    <c:forEach var="post" items="${posts}">
                        <li class="post-item">
                            <a href="${contextPath}/api/post/${post.id}" class="post-title">${post.title}</a>
                            <p>${fn:substring(post.contents, 0, 100)}...</p>
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

			<!-- 페이징 UI -->
			<div class="custom-pagination-paging">
			    <c:if test="${not empty totalPages and totalPages > 1}">
			
			        <!--이전 그룹 이동 버튼 -->
			        <a href="?page=${prevGroupPage}&size=${pageSize}" class="custom-page-button ${startPage > 1 ? '' : 'disabled'}">&lt;&lt;</a>
			
			        <!--이전 페이지 버튼 -->
			        <a href="?page=${currentPage - 1}&size=${pageSize}" class="custom-page-button ${currentPage > 1 ? '' : 'disabled'}">&lt;</a>
			
			        <!--현재 그룹의 페이지 번호 (최대 10개만 표시) -->
			        <c:forEach var="i" begin="${startPage}" end="${endPage}">
			            <a href="?page=${i}&size=${pageSize}" class="custom-page-button ${i == currentPage ? 'active' : ''}">${i}</a>
			        </c:forEach>
			
			        <!--다음 페이지 버튼 -->
			        <a href="?page=${currentPage + 1}&size=${pageSize}" class="custom-page-button ${currentPage < totalPages ? '' : 'disabled'}">&gt;</a>
			
			        <!--다음 그룹 이동 버튼 -->
			        <a href="?page=${nextGroupPage}&size=${pageSize}" class="custom-page-button ${endPage < totalPages ? '' : 'disabled'}">&gt;&gt;</a>
			
			    </c:if>
			</div>
        </div>
    </div>
<script>
    console.log("Pagination: startPage=${startPage}, endPage=${endPage}, currentPage=${currentPage}");
</script>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
