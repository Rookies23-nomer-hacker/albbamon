<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>채용 공고 등록</title>
<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>

<main class="container mt-5">
    <h2 class="text-center">채용 공고 등록</h2>
    <form id="recruitmentForm" enctype="multipart/form-data" onsubmit="event.preventDefault();">
        <div class="card p-4">
            <h3 class="mb-4" style="font-weight: bold;">모집 내용</h3>
            
            <!-- 공고 제목 -->
            <div class="form-group">
                <label for="title">공고 제목 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="title" name="title" placeholder="공고 제목을 입력하세요" style="background-color: #F1F3F5"required>
            </div>

            <!-- 공고 내용 -->
            <div class="form-group">
                <label for="contents" style="margin-top: 30px;">공고 내용 <span class="text-danger">*</span></label>
                <textarea class="form-control" id="contents" name="contents" rows="5" placeholder="공고 내용을 입력하세요" style="background-color: #F1F3F5" required></textarea>
            </div>

            <!-- 시급 -->
            <div class="form-group">
                <label for="wage" style="margin-top: 30px;">시급 <span class="text-danger">*</span></label>
                <input type="number" class="form-control" id="wage" name="wage" placeholder="시급을 입력하세요" style="background-color: #F1F3F5" required>
            </div>

            <!-- 마감 기한 -->
            <div class="form-group">
                <label for="dueDate" style="margin-top: 30px;">마감 기한 <span class="text-danger">*</span></label>
                <input type="datetime-local" class="form-control" id="dueDate" name="dueDate" style="background-color: #F1F3F5" required>
            </div>

            <!-- 파일 업로드 -->
            <div class="form-group">
                <label for="file" style="margin-top: 30px;">파일</label>
                <input type="file" class="form-control-file" id="file" name="file" required>
            </div>
			</div>
            <div class="form-group text-center">
                <button class="btn btn-primary btn-lg" onclick="submitForm()">공고 저장</button>
            </div>
        
    </form>
</main>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function submitForm() {
        console.log(${sessionScope.userid})
        if (!${sessionScope.userid}) {
            alert("로그인한 사용자만 공고를 작성할 수 있습니다.");
            return;
        }

        const formData = new FormData();

        // requestDto
        const requestDto = {
            "title": document.getElementById('title').value,
            "contents": document.getElementById('contents').value,
            "wage": document.getElementById('wage').value,
            "dueDate": document.getElementById('dueDate').value,
            "userId": ${sessionScope.userid}
        };
        const blob = new Blob([JSON.stringify(requestDto)], {
            type: 'application/json',
        });
        formData.append('requestDto', blob);

        // file
        var fileInput = document.getElementById('file');
        if (fileInput.files.length > 0) {
            formData.append("file", fileInput.files[0]);
        }

        sendToServer(formData);
    }

    function sendToServer(formData) {
        fetch(`${apiBaseUrl}/api/recruitment`, {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(result => {
                console.log('공고 등록 성공:', result);
                alert('공고가 성공적으로 등록되었습니다.');
                window.location.href = `${base_url}/recruitment/list`;
            })
            .catch(error => {
                console.error('공고 등록 실패:', error);
                alert('공고 등록에 실패했습니다.');
            });
    }
</script>


<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
