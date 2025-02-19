<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Posts</title>
</head>
<body>
    <h1>All Posts</h1>

    <c:forEach var="post" items="${posts}">
        <div class="post">
            <h2>${post.title}</h2>
            <p>${post.contents}</p>
            <p><strong>작성자:</strong> ${post.user.name}</p> <!-- 작성자 출력 -->
            <p><strong>작성일:</strong> ${post.createDate}</p> <!-- 생성일 출력 -->
            <!-- 파일 첨부가 있을 경우 파일명 표시 -->
            <c:if test="${not empty post.file}">
                <p><strong>첨부 파일:</strong> ${post.file}</p>
            </c:if>
        </div>
    </c:forEach>

</body>
</html>
