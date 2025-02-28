<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>         
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용 공고 수정</title>
    <link rel="stylesheet" href="${contextPath}/css/recruitment/recruitment.css">
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
<main class="container mt-5">
	<h2 class="text-center" style="font-weight: bold;">채용 공고 수정</h2>	
    <form id="recruitmentForm" action="${contextPath}/recruitment/${recruitment.id}/modify" method="POST">
		<div class="card p-4">
		    <h3 class="mb-4" style="font-weight: bold;">모집 내용</h3>
		    <div class="form-group">
		     <label for="contents" style="margin-top: 30px;"> 공고 제목 </label>
		        <span class="text-danger">*</span>
		        <input class="form-control" id="title" name="title" style="background-color: #F1F3F5" value="${recruitment.title}" style="background-color: #F1F3F5" />
		 </div>
		 <div class="form-group">
		     <label for="contents" style="margin-top: 30px;">공고 내용</label>
		        <span class="text-danger">*</span>
		        <textarea class="form-control" id="contents" name="contents" rows="5" style="background-color: #F1F3F5">${recruitment.contents}</textarea>
		    </div>
		    <div class="form-group">
		     <label for="contents" style="margin-top: 30px;">시급</label>
		        <span class="text-danger">*</span>
		        <input type="number" class="form-control" id="wage" name="wage" value="${recruitment.wage}" />
		    </div>
		    <div class="form-group">
		     <label for="contents" style="margin-top: 30px;">마감 기한</label>
		        <span class="text-danger">*</span>
		        <input type="datetime-local" class="form-control" id="dueDate" name="dueDate" value="${recruitment.dueDate}" />
		    </div>
		    <div class="form-group">
		    	<label for="file" style="margin-top: 30px;" >파일</label>
		    	<input type="file" class="form-control-file" id="file" name="file">
		    </div>
		</div>
           <div class="form-group text-center">
               <button class="btn btn-lg" style="color: #ffffff; background-color: #ff6600; margin-top: 40px;" type="submit">
                   공고 수정 완료
               </button>
           </div>
    </form>
    
</main>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>

</script>
<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>