<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
	<meta charset="UTF-8">
	<title>이력서 작성</title>
	<link rel="stylesheet" href="/css/resume/resume.css">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<script src="<%= request.getContextPath() %>/js/resume.js"></script>
	<script>let resumePersonal = "${resume.personal}";
    	let resumeWork_place_region = "${resume.work_place_region}";
        let resumeIntroduction = "${resume.industry_occupation}";
        let duplicated = "${duplicated}";</script>
	<div class="section">
		<div class="section-line"></div>
		<table id="portfolioTable" style="table-layout: fixed;">
			<thead>
				<th id="title" style="width: 630px; text-align: center;">이력서</th>
				<th id="date" style="width: 200px; text-align: center;">최종 수정일</th>
				<th id="volume" style="width: 200px; text-align: center;">관리</th>
				<th id="volume" style="width: 200px; text-align: center;">공개 여부</th>
				<th id="volume" style="width: 200px; text-align: center;">맞춤알바</th>
			</thead>
			<tbody id="portfolioTableBody">
				
			</tbody>
		</table>
		
		<div align="center" class="empty-portfolio" id="emptyMessage">등록된 이력서가 없습니다.</div>
		<div class="center-container">
		<button id="portfolio" type="button" class="save" onclick="location.href='<%= request.getContextPath() %>/api/resume/write'">이력서 작성</button>
		<input type="file" id="fileInput" style="display: none;" onchange="handleFileUpload(event)">
		</div>
		<div class="section-line-gry section-margin-top" style="margin-bottom: 300px;"></div>
		<div class="center-container">
	</div>
	</div>

	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
    <!-- Bootstrap JS CDN (Optional, if you need interactive components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>