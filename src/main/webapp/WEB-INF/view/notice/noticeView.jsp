<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <title>공지사항</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        * {
            font-family: "Noto Sans KR", sans-serif;
        }
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
		.post-item a:hover {
 			text-decoration: none;
  			color: black;
		}
	</style>

</head>	
<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <div class="container" style="width: 60%;">
        <!-- 헤더 영역 -->
        <div class="board-header" style="margin-top: 50px;">
            <h3 style="font-weight: bold;">공지사항</h3>
        </div>

        <div class="custom-pagination">
            <!-- 공지사항 리스트 -->
            <ul class="post-list">
                <c:if test="${not empty noticeList}">
                    <c:forEach var="notice" items="${noticeList}">
                        <li class="post-item">
                            <a href="${contextPath}/notice/${notice.id}" class="post-title">${notice.title}</a>
                            <p>${fn:substring(notice.contents, 0, 100)}...</p>
                            <div class="post-meta">
                                작성자: 관리자 | 작성일: ${notice.createDate}
                            </div>
                        </li>
                    </c:forEach>
                </c:if>

                <!-- 공지사항 없을 때 -->
                <c:if test="${empty noticeList}">
                    <div class="no-posts">등록된 공지사항이 없습니다.</div>
                </c:if>
            </ul>
        </div>
    </div>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
