<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	        background-size: cover;  /* 이미지가 화면에 꽉 차게 조정 */
	        background-position: center; /* 배경 이미지가 화면의 중앙에 위치 */
	        background-attachment: fixed; /* 스크롤 시 배경이 고정됨 */
	    }
	</style>
</head>
<body style="background-color: #f1f3f5;">

    <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <main class="container my-5">
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card">
                    <img src="/img/albbamonAd.png" class="card-img-top" style="width: 100%; height: 100%; object-fit: contain;" alt="광고1 이미지">
                    <div class="card-body">
                        <h5 class="card-title">광고 문의</h5>
                        <p class="card-text">albbamon1@albbamon.com</p>
						<a href="mailto:albbamon1@albbamon.com?subject=광고 문의&body=이메일을 통해 문의 내용을 작성해주세요." class="btn btn-primary">이메일 문의</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
					<img src="/img/ad.PNG" class="card-img-top" style="width: 100%; height: 100%; object-fit: contain;" alt="광고2 이미지">
                    <div class="card-body">
                        <h5 class="card-title">일하는 모든 이를 세상의 모든 일을 RESPECT - 알바몬</h5>
                        <p class="card-text">알바는 알바몬.</p>
                        <a href="https://www.albamon.com" class="btn btn-primary">알바몬 바로가기</a>
                    </div>
                </div>
            </div>
        </div>

		<div class="row mb-4">
		    <!-- 공고 리스트 테이블 -->
		    <div class="col-md-6">
		        <div class="card shadow-lg border-0 rounded-3">
		            <div class="card-header text-white" style="background-color: #ff6600; border: 5px;">
		                <h5 class="m-0">공고 리스트</h5>
						<p class="card-text">다양한 채용 공고를 확인하고 지원해 보세요.<a href="/recruitment/list" class="btn btn-light text-dark border-2 border-dark fw-bold float-end">전체보기</a></p>
		            </div>
		            <div class="card-body">
		                <table class="table table-hover">
		                    <thead class="table-light">
		                        <tr>
		                            <th scope="col" style="width: 60%;">공고 제목</th>
		                            <th scope="col" style="width: 20%;">시급</th>
		                            <th scope="col" style="width: 20%;">공고일</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <c:forEach var="recruitment" items="${recruitmentList}">
		                            <c:if test="${recruitmentList.indexOf(recruitment) < 5}">
		                                <tr>
		                                    <td style="max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
		                                        <a href="/recruitment/${recruitment.id}/apply" class="text-decoration-none text-body">
		                                            ${recruitment.title}
		                                        </a>
		                                    </td>
		                                    <td>${recruitment.wage}</td>
		                                    <td>${recruitment.dueDate}</td>
		                                </tr>
		                            </c:if>
		                        </c:forEach>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>

		    <!-- 커뮤니티 게시글 테이블 -->
		    <div class="col-md-6">
		        <div class="card shadow-lg border-0 rounded-3">
		            <div class="card-header text-white" style="background-color: #ff6600; border: 5px;">
		                <h5 class="m-0">커뮤니티 게시글</h5>
						<p class="card-text">알빠몬 커뮤니티에 다양한 게시글을 확인해 보세요.<a href="/api/post" class="btn btn-light text-dark border-2 border-dark fw-bold float-end">전체보기</a></p>
		            </div>
		            <div class="card-body">
		                <table class="table table-hover">
		                    <thead class="table-light">
		                        <tr>
		                            <th scope="col" style="width: 60%;">제목</th>
		                            <th scope="col" style="width: 20%;">게시일</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <c:forEach var="post" items="${posts}">
		                            <c:if test="${posts.indexOf(post) < 5}">
		                                <tr>
		                                    <td style="max-width: 200px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
		                                        <a href="/api/post/${post.postId}" class="text-decoration-none text-body">
		                                            ${post.title}
		                                        </a>
		                                    </td>
		                                    <td>${post.createDate}</td>
		                                </tr>
		                            </c:if>
		                        </c:forEach>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>
		</div>

        <div class="row">
            <div class="col-md-8">
                <h3 class="pb-4 mb-4 fst-italic border-bottom">From the Firehose</h3>

                <article class="blog-post">
                    <h2 class="display-5 link-body-emphasis mb-1">Sample blog post</h2>
                    <p class="blog-post-meta">January 1, 2021 by <a href="#">Mark</a></p>
                    <p>Content goes here...</p>
                </article>
            </div>

            <div class="col-md-4">
                <div class="position-sticky" style="top: 2rem;">
                    <div class="p-4 mb-3 bg-body-tertiary rounded">
                        <%@ include file="/WEB-INF/view/common/calendar.jsp" %>
                    </div>
                    <div>
                        <h4 class="fst-italic">스크랩 공고</h4>
                        <ul class="list-unstyled">
                            <li><a href="#">편의점 알바 구합니다.</a></li>
                            <li><a href="#">스크랩 알바</a></li>
                        </ul>
                    </div>

                    <div class="p-4">
                        <h4 class="fst-italic"></h4>
                        <ol class="list-unstyled mb-0">
                            <li><a href="#">개인정보보호 Tip</a></li>
                            <li><a href="#">문의/제안/신고</a></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/view/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
