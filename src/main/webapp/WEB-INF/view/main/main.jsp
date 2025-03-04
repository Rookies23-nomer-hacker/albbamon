<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알빠몬 | 세상의 모든 알바</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
	    /* 전체 페이지 배경 이미지 설정 */
	    body {
	        background-size: cover;
	        background-position: center;
	        background-attachment: fixed;
	    }
        .text-btn {
            text-decoration: none;
            color: #6c757d;
        }
        .text-btn:hover {
            text-decoration: none;
            color: #ff6600;
            font-weight: bold;
        }
	</style>
</head>
<body style="background-color: #ffffff;">

    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <main class="container my-5">
        <div class="row mb-4">
            <div class="col-md-6" style="width: 50%">
                <div class="card">
                    <img src="${contextPath}/img/albbamonAd.png" class="card-img-top" style="width: 100%; height: 80%; object-fit: contain;" alt="광고1 이미지">
                    <div class="card-body">
                        <h5 class="card-title" style="font-weight: bold;">광고 문의</h5>
                        <p class="card-text">albbamon1@albbamon.com</p>
						<a href="mailto:albbamon1@albbamon.com?subject=광고 문의&body=이메일을 통해 문의 내용을 작성해주세요." class="float-end text-btn">이메일 문의 〉</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6" style="width: 50%">
                <div class="card">
					<img src="${contextPath}/img/byoun.jpg" class="card-img-top" style="width: 100%; height: 80%; object-fit: contain;" alt="광고2 이미지">
                    <div class="card-body">
                        <h5 class="card-title" style="font-weight: bold;">일하는 모든 이를 세상의 모든 일을 RESPECT - 알바몬</h5>
                        <p class="card-text">알바는 알바몬.</p>
                        <a href="https://www.albamon.com" class="float-end text-btn">알바몬 바로가기 〉</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card shadow-lg border-0 rounded-3">
                    <div class="card-body">
                        <div class="row row-cols-1 row-cols-md-4 g-4">
                            <c:forEach var="recruitment" items="${recruitmentList}" varStatus="status">
                                <div class="col">
                                    <div class="card h-100 shadow border-0">
                                        <div class="card-body">
                                            <p class="card-text" style="color: #555555; font-weight: bold;">${recruitment.company}</p>
                                            <h5 class="card-title">
                                                <a href="${contextPath}/recruitment/list/${recruitment.id}" class="text-decoration-none" style="color: black; font-size: 18px; font-weight: bold">
                                                    ${recruitment.title}
                                                </a>
                                            </h5>
                                            <p class="text-muted">
                                                <span style="color: #FF6600; font-weight: bold">시급</span>
                                                <span style="color: #5a6268; font-weight: bold">${recruitment.wage}</span>원
                                            </p>
                                        </div>
                                        <div class="card-footer text-end">
                                            <small class="text-muted">~ ${recruitment.dueDate}</small>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${(status.index + 1) % 4 == 0}">
                                    </div><div class="row row-cols-1 row-cols-md-4 g-4">
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>