<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지원서 목록</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="">
        <h2 class="title" style="font-weight: bold; margin-top: 40px;">지원서 목록</h2>
        <div class="apply-list-container" style="margin-top: 60px;">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th style="width: 50px;">ID</th>
                    <th style="width: 80px;">지원자명</th>
                    <th style="width: 70px;">학력</th>
                    <th style="width: 100px;">학력 상태</th>
                    <th style="width: 80px;">Personal</th>
                    <th style="width: 100px;">근무 지역</th>
                    <th style="width: 100px;">근무 도시</th>
                    <th style="width: 100px;">산업/직무</th>
                    <th style="width: 100px;">고용 형태</th>
                    <th style="width: 100px;">근무 기간</th>
                    <th style="width: 100px;">근무 일자</th>
                    <th style="width: 200px;">포트폴리오</th>
                    <th>등록일</th>
                    <th style="width: 100px;">지원 상태</th>
					<th style="width: 200px;">합격/불합격</th>
                </tr>
                </thead>
                <tbody>
					<c:forEach var="apply" items="${applyList}">
					    <tr>
					        <td>${apply.id}</td>
					        <td>${apply.userName}</td>
					        <td>${apply.school}</td>
					        <td>${apply.status}</td>
					        <td>${apply.personal}</td>
					        <td>${apply.workPlaceRegion}</td>
					        <td>${apply.workPlaceCity}</td>
					        <td>${apply.industryOccupation}</td>
					        <td>${apply.employmentType}</td>
					        <td>${apply.workingPeriod}</td>
					        <td>${apply.workingDay}</td>
					        <td>
					        	<a href="${apply.apiUrl}/api/resume/download?fileName=${apply.portfolioname}"
			                       style="text-decoration: none; color: inherit; display: flex; align-items: center;"
			                       download>
			                        <img src="https://cdn-icons-png.flaticon.com/512/2991/2991108.png"
			                             alt="파일 아이콘" width="20" height="20" style="margin-right: 5px;">
			                        <span>${fn:substring(apply.portfolioname, 0, fn:indexOf(apply.portfolioname, '.') - 15)}${fn:substring(apply.portfolioname, fn:indexOf(apply.portfolioname, '.'), fn:length(apply.portfolioname))}</span>
			                    </a>
					        
					        </td>
<%-- 					        <td>
					        	<a href="${api_url}/api/resume/download?fileName=${apply.resume_imgname}"
			                       style="text-decoration: none; color: inherit; display: flex; align-items: center;"
			                       download>
			                        <img src="https://cdn-icons-png.flaticon.com/512/2991/2991108.png"
			                             alt="파일 아이콘" width="20" height="20" style="margin-right: 5px;">
			                        <span>${apply.resume_imgname}</span>
			                    </a>
					        
					        </td> --%>
					        <td>${apply.createDate}</td>
					        <td>${apply.applyStatus}</td>
					        <td>
					            <div>
					                <!-- apply.id를 사용하여 버튼에 대한 클릭 이벤트 설정 -->
									<button class="apply-pass-btn" onclick="updateStatus(${apply.id}, 'PASSED')">합격</button>
									<button class="apply-fail-btn" onclick="updateStatus(${apply.id}, 'FAILED')">불합격</button>
					            </div>
					        </td>
					    </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
        <div class="button-container" style="margin-top: 60px;">
            <button class="btn-primary" onclick="location.href='${contextPath}/recruitment/write'">채용 공고 등록</button>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>

<script defer>
	document.addEventListener("DOMContentLoaded", function () {
		function updateStatus(applyId, status) {
			const requestData = {
				status: status
			};

			fetch(`${apiBaseUrl}/api/recruitment/${recruitmentId}/apply/` + applyId + `/status`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(requestData)
			})
					.then(response => response.json())
					.then(data => {
						alert(data.message);
						location.reload();
					})
					.catch(error => {
						console.error('Error:', error);
						alert('오류가 발생했습니다.');
					});
		}

		// updateStatus를 전역 객체로 설정
		window.updateStatus = updateStatus;
	});
</script>


</body>
</html>