<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통합 개인 회원가입</title>
    <style>
        /* 헤더 스타일 */
        .header-wrapper {
            width: 100%;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        /* 회원가입 컨테이너 (헤더와 겹치지 않도록 패딩 추가) */
        .register-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 500px;
            height: 850px;
            border: 2px solid #ff6600;
            margin-top: 50px; /* 헤더와 겹치지 않도록 설정 */
            margin-bottom: 80px;
            margin-left: 35%;
        }

        h1 {
            font-size: 20px !important;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            background-color: #f5f5f5;
        }

        .register-btn {
            width: 100%;
            background-color: #ff6600;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 20px;
        }

        .register-btn:hover {
            background-color: #e55a00;
        }

        .links {
            margin-top: 20px;
            font-size: 14px;
            color: #666;
            text-align: center;
        }

        .links a {
            text-decoration: none;
            color: #666;
            margin: 0 10px;
        }

        .links a:hover {
            color: #ff6600;
        }
.terms-container {
    width: 100%; /* 입력 필드와 동일한 너비로 설정 */
    max-width: 700px; /* 최대 너비 지정 */
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    margin-bottom: 10px; /* 입력 필드와 여백 확보 */
}

/* 개별 약관 항목 */
.terms-item {
    display: flex;
    align-items: center; /* 체크박스와 텍스트를 수직 정렬 */
    justify-content: space-between;
    padding: 10px;
    border-bottom: 1px solid #ddd;
    cursor: pointer;
    gap: 10px; /* 체크박스와 텍스트 간격 확보 */
}

.terms-item:last-child {
    border-bottom: none;
}

.terms-item input[type="checkbox"] {
    width: 18px;
    height: 18px;
    margin-right: 10px; /* 체크박스와 텍스트 사이 간격 */
}

.bold-text {
    font-size: 14px;
    font-weight: bold;
    color: #333;
    flex-grow: 1; /* 체크박스 옆 텍스트가 올바르게 배치되도록 */
}

.sub-text, .detail-text {
    font-size: 12px;
    color: #888;
    margin-left: auto;
}

.detail-arrow {
    font-size: 16px;
    color: #999;
}
.bottom-wrapper {
	width: 100%;
	}

    </style>
</head>
<body>

    <!-- 헤더 추가 -->
        <%@ include file="/WEB-INF/view/common/header.jsp" %>

    <!-- 회원가입 폼 -->
    <div class="register-container">
        <h1>통합 개인 회원가입</h1>
        <form action="${contextPath}/api/user" method="post">
    <div class="terms-container">

    <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(필수) 만 15세 이상입니다.</span>
        <span class="detail-arrow">></span>
    </label>

    <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(필수) 서비스 이용약관 동의</span>
        <span class="detail-arrow">></span>
    </label>

    <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(필수) 개인정보 수집 및 이용 동의</span>
        <span class="detail-arrow">></span>
    </label>

    <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(선택) 알바몬 제트 이용약관 동의</span>
        <span class="detail-arrow">></span>
    </label>

    <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(선택) 광고성 정보 이메일/SMS 수신 동의</span>
        <span class="detail-arrow">></span>
    </label>

<!--     <label class="terms-item">
        <input type="checkbox">
        <span class="bold-text">(선택) 개인정보 수집 및 이용 동의-공고추천·혜택</span>
        <span class="detail-text">맞춤알바 등 다양한 혜택 알림 제공</span>
        <span class="detail-arrow">></span>
    </label> -->
</div>
            <label for="phone">휴대폰번호 <span style="color: red;">*</span></label>
            <input type="text" placeholder="휴대폰 번호 '-' 제외하고 입력" name="phone" id="phone" required>

            <label for="email">이메일 <span style="color: red;">*</span></label>
            <input type="email" placeholder="이메일 입력" name="email" id="email" required>

            <label for="password">비밀번호 <span style="color: red;">*</span></label>
            <input type="password" placeholder="비밀번호 입력" name="password" id="password" required>

            <label for="name">이름 <span style="color: red;">*</span></label>
            <input type="text" placeholder="이름 입력" name="name" id="name" required>

            <button type="submit" class="register-btn">가입하기</button>
        </form>

        <div class="links">
            <a href="${contextPath}/api/user/sign-in">이미 계정이 있으신가요? 로그인</a>
        </div>
    </div>
    <div class="bottom-wrapper">
    	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
    </div>
</body>
</html>
