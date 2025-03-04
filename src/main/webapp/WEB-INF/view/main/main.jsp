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
	</style>
</head>
<body style="background-color: #ffffff;">

    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <main class="container my-5">
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <img src="${contextPath}/img/albbamonAd.png" class="card-img-top" style="width: 100%; height: 100%; object-fit: contain;" alt="광고1 이미지">
                    <div class="card-body">
                        <h5 class="card-title" style="font-weight: bold;">광고 문의</h5>
                        <p class="card-text">albbamon1@albbamon.com</p>
						<a href="mailto:albbamon1@albbamon.com?subject=광고 문의&body=이메일을 통해 문의 내용을 작성해주세요." class="btn btn-light text-dark border-2 border-dark fw-bold float-end">이메일 문의</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
					<img src="${contextPath}/img/byoun.jpg" class="card-img-top" style="width: 100%; height: 100%; object-fit: contain;" alt="광고2 이미지">
                    <div class="card-body">
                        <h5 class="card-title" style="font-weight: bold;">일하는 모든 이를 세상의 모든 일을 RESPECT - 알바몬</h5>
                        <p class="card-text">알바는 알바몬.</p>
                        <a href="https://www.albamon.com" class="btn btn-light text-dark border-2 border-dark fw-bold float-end">알바몬 바로가기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card shadow-lg border-0 rounded-3">
                    <div class="card-header text-white" style="background-color: #F1F3F5; border: 5px;">
                        <h5 class="m-0" style="font-weight: bold; color: #000000;">공고 리스트</h5>
                        <p class="card-text" style="color: #000000;">다양한 채용 공고를 확인하고 지원해 보세요.
                            <a href="${contextPath}/recruitment/list" class="btn btn-light text-dark border-2 border-dark fw-bold float-end">전체보기</a>
                        </p>
                    </div>
                    <div class="card-body" style="height: 550px;">
                        <div class="row row-cols-1 row-cols-md-4 g-4">
                            <c:forEach var="recruitment" items="${recruitmentList}" varStatus="status">
                                <div class="col">
                                    <div class="card h-100 shadow-sm border-0">
                                        <div class="card-body">
                                            <h5 class="card-title">
                                                <a href="${contextPath}/recruitment/list/${recruitment.id}" class="text-decoration-none text-dark">
                                                    ${recruitment.title}
                                                </a>
                                            </h5>
                                            <p class="card-text">${recruitment.company}</p>
                                            <p class="text-muted">시급: ${recruitment.wage}원</p>
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