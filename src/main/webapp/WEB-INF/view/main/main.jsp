<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Posts</title>
</head>
<body>
    <h1>All Posts</h1>
    <ul>
        <c:forEach var="post" items="${posts}">
            <li>${post.title}</li>
        </c:forEach>
    </ul>
</body>
</html>