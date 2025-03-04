<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>알바경험담 보기</title>
    <style>
        /* 헤더 스타일 */
        .header-wrapper {
            width: 100%;
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
            padding-top: 120px;
            padding-bottom: 40px;
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

        .menu-options a, .menu-options button {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: #333;
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            cursor: pointer;
        }

        .menu-options a:hover, .menu-options button:hover {
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

        // 외부 클릭 시 메뉴 닫기
        document.addEventListener('click', function(event) {
            const menu = document.getElementById('menuOptions');
            const button = document.getElementById('menuButton');
            if (!menu.contains(event.target) && !button.contains(event.target)) {
                menu.style.display = 'none';
            }
        });

        // ✅ 게시글 삭제 함수//
        function deletePost(postId) {
		    if (confirm("정말 삭제하시겠습니까?")) {
		        fetch(`${contextPath}/api/post/delete/${postId}`, {  // ✅ 절대 경로 사용
		            method: "DELETE",
		            headers: {
		                "Content-Type": "application/json"
		            }
		        })
		        .then(response => response.text().then(text => ({ status: response.status, body: text }))) // ✅ 응답을 문자열로 처리
		        .then(({ status, body }) => {
		            if (status === 200) {  // ✅ 응답 상태 코드가 200이면 성공
		                alert("게시글이 삭제되었습니다.");
		                window.location.href = `${contextPath}/api/post`;  // ✅ 게시글 목록으로 이동
		            } else {
		                alert("삭제에 실패했습니다: " + body);
		            }
		        })
		        .catch(error => {
		            console.error("삭제 중 오류 발생:", error);
		            alert("삭제 요청 중 오류가 발생했습니다.");
		        });
		    }
		}
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

                <!-- 📌 메뉴 버튼 -->
                <div class="post-menu">
                    <button id="menuButton" class="menu-button" onclick="toggleMenu()">⋯</button>
                    <div class="menu-options" id="menuOptions">
                        <%-- ✅ 세션 사용자와 작성자 비교 --%>
                        <c:choose>
                            <c:when test="${sessionUserId == post.userId}">
                                <a href="${contextPath}/api/post/update/${post.postId}">수정하기</a>
                                <button onclick="deletePost(${post.postId})">삭제하기</button>
                            </c:when>
                            <c:otherwise>
                                <a href="#">신고하기</a>
                                <a href="#">차단하기</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="post-content">
                <p><c:out value="${post.contents}" default="내용이 없습니다."/></p>
            </div>
            <div class="post-img">
                <c:if test="${post.file != 'null'}">
                    <img src="${post.file}" alt="이미지" class="img-fluid" style="max-width: 100%; height: auto;"/>
                </c:if>
			</div>
        </div>
    </div>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
