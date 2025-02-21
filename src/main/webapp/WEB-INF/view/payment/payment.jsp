<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 페이지</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 포트원 SDK 라이브러리 추가 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<script src="/js/payment/payment.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp" %>
    <div class="container">
        <h2 class="mt-5">결제 정보 입력</h2>

        <!-- 사용자 정보 입력 폼 -->
        <form id="paymentForm">
            <div class="mb-3">
                <label for="buyer_name" class="form-label">이름</label>
                <input type="text" class="form-control" id="buyer_name" placeholder="이름을 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="buyer_email" class="form-label">이메일</label>
                <input type="email" class="form-control" id="buyer_email" placeholder="이메일을 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="buyer_tel" class="form-label">전화번호</label>
                <input type="text" class="form-control" id="buyer_tel" placeholder="전화번호를 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="buyer_addr" class="form-label">주소</label>
                <input type="text" class="form-control" id="buyer_addr" placeholder="주소를 입력하세요" required>
            </div>
            <div class="mb-3">
                <label for="buyer_post_code" class="form-label">우편번호</label>
                <input type="text" class="form-control" id="buyer_post_code" placeholder="우편번호를 입력하세요" required>
            </div>
        </form>
		<!-- 결제 버튼 -->
		<button type="button" class="btn btn-primary" id="payment">결제하기</button>
    </div>
	
	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>
