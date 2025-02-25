<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>지원서 목록</title>
    <link rel="stylesheet" href="/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
    <div class="recruitment-container">
        <h2 class="title">지원서 목록</h2>
        <div class="card">
            <table class="recruitment-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>지원자명</th>
                    <th>학력</th>
                    <th>학력 상태</th>
                    <th>Personal</th>
                    <th>근무 지역</th>
                    <th>근무 도시</th>
                    <th>산업/직무</th>
                    <th>고용 형태</th>
                    <th>근무 기간</th>
                    <th>근무 일자</th>
                    <th>포트폴리오</th>
                    <th>등록일</th>
                    <th>지원 상태</th>
					<th>불합격/합격</th>
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
					        <td>${apply.portfoliourl}</td>
					        <td>${apply.createDate}</td>
					        <td>${apply.applyStatus}</td>
					        <td>
					            <div class="form-check form-switch d-flex justify-content-center">
					                <!-- apply.id를 사용하여 버튼에 대한 클릭 이벤트 설정 -->
									<button class="btn-primary" onclick="updateStatus(${apply.id}, 'PASSED')">합격</button>
									<button class="btn-primary" onclick="updateStatus(${apply.id}, 'FAILED')">불합격</button>
					            </div>
					        </td>
					    </tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
        <div class="button-container">
            <button class="btn-primary" onclick="location.href='/recruitment/write'">채용 공고 등록</button>
        </div>
    </div>
</main>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>

<script>
	function updateStatus(applyId, status) {
	    const recruitmentId = ${recruitmentId};  // 서버에서 전달된 recruitmentId를 JavaScript로 사용

	    const requestData = {
	        status: status  // 상태 값만 서버로 보내기
	    };

	    // API 호출 (POST 요청)
	    fetch(`http://localhost:60085/api/recruitment/${recruitmentId}/apply/`+applyId+`/status`, {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify(requestData)  // status 값이 동적으로 전달됨
	    })
	    .then(response => response.json())  // JSON으로 응답 처리
	    .then(data => {
	        alert(data.message);  // 서버에서 전달한 메시지 출력
	    })
	    .catch(error => {
	        console.error('Error:', error);
	        alert('오류가 발생했습니다.');
	    });
	}

</script>

</body>
</html>
