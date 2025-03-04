<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>알빠몬 | 세상의 모든 알바</title>
	
	<style>
	    html, body {
	        height: 100%;
	        margin: 0;
	    }
	    
	    .wrapper {
	        min-height: 100%;
	        display: flex;
	        flex-direction: column;
	    }

	    .content {
	        flex: 1;
	    }
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp" %>
	<div class="wrapper">
	    <!-- Main Content -->
	    <div class="content">
	        <div class="container">
	            <h1>알빠몬</h1>
				<h2>500 - 서버 내부 오류입니다.</h2>
				<a href="/">홈으로 돌아가기</a>
	        </div>
	    </div>
	
	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
	</div>
</body>
</html>
