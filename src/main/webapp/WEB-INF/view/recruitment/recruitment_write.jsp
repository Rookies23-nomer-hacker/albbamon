<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 등록</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main>
	<form id="recruitmentForm" enctype="multipart/form-data" onsubmit="event.preventDefault(); submitForm();">
	
        <div class="recruitment-container">
            <h2>채용 공고 등록</h2>
            <div class="orange-form">
                <h3 class="section-margin-top2">모집 내용</h3>
                <div class="section-line"></div>
                <div class="section-text section-bold section-margin-top">공고 제목
                    <span class="section-head__required">*</span>
                    <input class="section-margin-left section-input-text" id="title" name="title" placeholder="공고 제목을 입력하세요"/>
                </div>
                <div class="section-text section-bold section-margin-top">공고 내용
                    <span class="section-head__required">*</span>
                    <textarea class="section-margin-left section-textarea" id="contents" name="contents" placeholder="공고 내용을 입력하세요"></textarea>
                </div>
                <div class="section-text section-bold section-margin-top">시급
                    <span class="section-head__required">*</span>
                    <input type="number" class="section-margin-left section-input-number" id="wage" name="wage" style="margin-left: 8%;"/>
                </div>
                <div class="section-text section-bold section-margin-top">마감 기한
                    <span class="section-head__required">*</span>
                    <input type="datetime-local" class="section-margin-left section-input-datetime-local" id="dueDate" name="dueDate"/>
                </div>
                <div class="section-text section-bold section-margin-top">파일
                    <span class="section-head__required">*</span>
                    <input type="file" id="file" name="file"/>
                </div>
            </div>
            <div class="button-container">
                <button type="submit" class="save">
                    공고 저장
                </button>
            </div>
        </div>
    </form>
</main>
<script>
	function submitForm() {
	    var form = document.getElementById('recruitmentForm');
	    var title = document.getElementById('title').value;
	    var contents = document.getElementById('contents').value;
	    var wage = document.getElementById('wage').value;
	    var dueDate = document.getElementById('dueDate').value;
	    var fileInput = document.getElementById('file');
	    var userId = '6'; // 세션에서 사용자 ID를 가져옵니다. 예시로 '6' 설정
	    var apiBaseUrl = "${apiBaseUrl}";
	    
	    if (!userId) {
	        alert("로그인한 사용자만 공고를 작성할 수 있습니다.");
	        return;
	    }

	    // FormData 객체 생성 (파일과 텍스트 데이터를 함께 전송)
	    var formData = new FormData();
	    formData.append("title", title);
	    formData.append("contents", contents);
	    formData.append("wage", wage);
	    formData.append("dueDate", dueDate);  // 날짜는 '2025-04-20T00:00:00' 형식으로 서버에 전송됨.
	    formData.append("userId", userId);

	    // 파일이 있으면 FormData에 추가
	    if (fileInput.files.length > 0) {
	        formData.append("file", fileInput.files[0]); // 파일을 FormData에 추가
	    }
		for (var pair of formData.entries()) {
		    console.log(pair[0]+ ': ' + pair[1]);
		}
	    // 서버로 FormData 전송
	    sendToServer(formData);
	}

	function sendToServer(formData) {
	    fetch(`${apiBaseUrl}/api/recruitment`, {
	        method: 'POST',
	        body: formData, // FormData 객체 전송
	    })
	    .then(response => response.json()) // 응답을 JSON 형식으로 처리
	    .then(result => {
	        console.log('공고 등록 성공:', result);
	    })
	    .catch(error => {
	        console.error('공고 등록 실패:', error);
	    });
		for (var pair of formData.entries()) {
		    console.log(pair[0]+ ': ' + pair[1]);
		}
	}
</script>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
