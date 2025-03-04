<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지원 현황</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<script>
    let applySuccess = ${applySuccess};
    if(applySuccess) {
        alert("지원이 완료되었습니다")
        location.href='/apply/list'
    }
</script>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="container" style="width: 60%;">
        <div class="board-header" style="margin-top: 50px;">
            <h3 style="font-weight: bold;">지원 현황</h3>
        </div>
        <div class="custom-pagination" style="margin-top: 60px;">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th>지원일</th>
                    <th>기업명</th>
                    <th>공고 제목</th>
                    <th>시급</th>
                    <th>채용 결과</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="apply" items="${applyList}">
                        <tr>
                            <td>${apply.createDate}</td>
                            <td>${apply.company}</td>
                            <td>${apply.title}</td>
                            <td>${apply.wage}</td>
                            <td>${apply.status}</td>
                        </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>