<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이력서 작성</title>
	<link rel="stylesheet" href="${contextPath}/css/resume/resume.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp" %>
	<script src="<%= request.getContextPath() %>/js/resume.js"></script>
	<script>var resumePersonal = "${resume.personal}";
    	var resumeWork_place_region = "${resume.work_place_region}";
        var resumeIntroduction = "${resume.industry_occupation}";
        var duplicated = "${duplicated}";
        var base_url = "${contextPath}";
        var deleted = "${delete}"
        var resumeId = "${resume.resume_id}";</script>
	<div class="section" style="margin-left: 7%;">
	<div class="orange-form-resume">
		<div class="section-line" style="width: 100%; margin-top: 30px;"></div>
		<table id="portfolioTable" style="table-layout: fixed;">
			<thead>
				<th id="title" style="width: 30%; text-align: center;">이력서</th>
				<th id="date" style="width: 15%; text-align: center;">최종 수정일</th>
				<th id="volume" style="width: 15%; text-align: center;">관리</th>
				<th id="volume" style="width: 15%; text-align: center;">공개 여부</th>
				<th id="volume" style="width: 15%; text-align: center;">맞춤알바</th>
			</thead>
			<tbody id="portfolioTableBody">
				
			</tbody>
		</table>
		
		<div align="center" class="empty-portfolio" id="emptyMessage" style="margin-left: 0%;">등록된 이력서가 없습니다.</div>
		</div>
		<div class="center-container">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
		<button id="portfolio" type="button" class="save" style="margin-left: 20%;" onclick="location.href=base_url + '/api/resume/write'">이력서 작성</button>
		<input type="file" id="fileInput" style="display: none;" onchange="handleFileUpload(event)">
		</div>
		<div class="center-container">
	</div>
	</div>
	
	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
    <!-- Bootstrap JS CDN (Optional, if you need interactive components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>