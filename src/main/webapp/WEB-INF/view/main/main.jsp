<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알빠몬 | 세상의 모든 알바</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>
	
	<main class="container" style="background-color: white;">
		<div class="p-4 rounded text-body-emphasis bg-white">
		  <div class="row">
		    <div class="col-lg-6 px-0">
		      <h1 class="display-4 fst-italic"></h1>
		      <img src="https://file2.jobkorea.co.kr/Event/Event_Main_View.asp?FN=PC_Img_afshqoxq19132900.jpg" class="img-fluid">
		    </div>
		    <div class="col-lg-6 px-0">
		      <img src="https://file2.jobkorea.co.kr/Event/Event_Main_View.asp?FN=PC_Img_afshqoxq19132900.jpg" class="img-fluid">
		    </div>
		  </div>
		</div>

	  <div class="row mb-2">
	      <!-- 왼쪽 -->
	      <div class="col-md-6">
	          <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
	              <div class="col p-4 d-flex flex-column position-static">
	                  <strong class="d-inline-block mb-2 text-primary-emphasis">커뮤니티</strong>
	                  <div class="mb-1 text-body-secondary text-end">
	                      <a href="/communityList" class="text-body-secondary text-decoration-none">전체보기</a>
	                  </div>
	                  <div class="card-body">
	                      <table class="table table-bordered table-striped table-hover">
	                          <thead>
	                              <tr>
	                                  <th scope="col">제목</th>
	                                  <th scope="col">내용미리보기</th>
	                                  <th scope="col">올린 날짜</th>
	                              </tr>
	                          </thead>
	                          <tbody>
	                              <c:forEach var="post" items="${posts}" >
	                                  <tr>
	                                      <td>${post.title}</td>
	                                      <td>${post.contents}</td>
	                                      <td>${post.createDate}</td>
	                                  </tr>
	                              </c:forEach>
	                          </tbody>
	                      </table>
	                  </div>
	              </div>
	          </div>
	      </div>
	      
	      <!-- 오른쪽 -->
	      <div class="col-md-6">
	          <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
	              <div class="col p-4 d-flex flex-column position-static">
	                  <strong class="d-inline-block mb-2 text-primary-emphasis">QnA</strong>
					  <div class="mb-1 text-body-secondary text-end">
					      <a href="/QnAList" class="text-body-secondary text-decoration-none">전체보기</a>
					  </div>
	                  <div class="card-body">
	                      <table class="table table-bordered table-striped table-hover">
	                          <thead>
	                              <tr>
	                                  <th scope="col">제목</th>
	                                  <th scope="col">내용미리보기</th>
	                                  <th scope="col">올린 날짜</th>
	                              </tr>
	                          </thead>
	                          <tbody>
	                              <c:forEach var="qna" items="${qnaList}">
	                                  <tr>
	                                      <td>${qna.title}</td>
	                                      <td>${qna.contents}</td>
	                                      <td>${qna.createDate}</td>
	                                  </tr>
	                              </c:forEach>
	                          </tbody>
	                      </table>
	                  </div>
	              </div>
	          </div>
	      </div>
	  </div>
	  
	  <div class="row g-5">
	    <div class="col-md-8">
	      <h3 class="pb-4 mb-4 fst-italic border-bottom">
	        From the Firehose
	      </h3>

	      <article class="blog-post">
	        <h2 class="display-5 link-body-emphasis mb-1">Sample blog post</h2>
	        <p class="blog-post-meta">January 1, 2021 by <a href="#">Mark</a></p>

	      </article>

	    </div>

	    <div class="col-md-4">
	      <div class="position-sticky" style="top: 2rem;">
	        <div class="p-4 mb-3 bg-body-tertiary rounded">
	          <h4 class="fst-italic">사이드바????????</h4>
	          <p class="mb-0">Customize this section to tell your visitors a little bit about your publication, writers, content, or something else entirely. Totally up to you.</p>
	        </div>

	        <div>
	          <h4 class="fst-italic">Recent posts</h4>
	          <ul class="list-unstyled">
	            <li>
	              <div class="col-lg-8">
	                <small class="text-body-secondary">스크랩 알바</small>
	                <a href="#"><h6 class="mb-0">편의점 알바 구합니다.</h6></a>
	              </div>
	            </li>
				<li>
				  <div class="col-lg-8">
				    <small class="text-body-secondary">최근 공고</small>
				    <a href="#"><h6 class="mb-0">편의점 알바 구합니다.</h6></a>
				  </div>
				</li>
	            <li>
	              <a class="d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center py-3 link-body-emphasis text-decoration-none border-top" href="#">
	                <svg class="bd-placeholder-img" width="100%" height="96" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false"><rect width="100%" height="100%" fill="#777"/></svg>
	                <div class="col-lg-8">
	                  <h6 class="mb-0">Longer blog post title: This one has multiple lines!</h6>
	                  <small class="text-body-secondary">January 13, 2024</small>
	                </div>
	              </a>
	            </li>
	          </ul>
	        </div>

	        <div class="p-4">
	          <h4 class="fst-italic">Archives</h4>
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
    <!-- Bootstrap JS CDN (Optional, if you need interactive components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
