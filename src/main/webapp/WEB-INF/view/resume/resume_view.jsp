<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이력서 조회</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .resume-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: left;
            width: 800px;
            border: 2px solid #ff6600;
            margin-top: 50px;
        }

        h1, h2 {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }

        .profile-container {
            display: flex;
            align-items: center;
            gap: 20px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 20px;
            margin-bottom: 20px;
        }

        .profile-photo {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #ddd;
        }

        .profile-info {
            font-size: 14px;
        }

        .section {
            margin-bottom: 20px;
        }

        .resume-item {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 5px;
            background-color: #fff;
            margin-bottom: 10px;
        }

        .resume-header {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .resume-content {
            font-size: 14px;
            color: #666;
        }
        .footer {
			    width: 100%;  /* 전체 너비 사용 */
			    left: 0;
			    bottom: 0;
		}
    </style>
</head>
<body>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
    <div class="resume-container">
        <h1>이력서 조회</h1>
        
        <div class="profile-container">
            <div class="profile-photo"></div>
            <div class="profile-info">
                <p><strong>이름:</strong> 홍길동</p>
                <p><strong>나이:</strong> 25세 (1999년생)</p>
                <p><strong>주소:</strong> 서울특별시 강남구</p>
                <p><strong>이메일:</strong> example@email.com</p>
                <p><strong>휴대폰 번호:</strong> 010-1234-5678</p>
            </div>
        </div>

        <div class="section">
            <h2>학력</h2>
            <div class="resume-item">
                <div class="resume-header">대학교 (4년제) 졸업</div>
                <div class="resume-content">서울대학교 컴퓨터공학과 (2015 - 2019)</div>
            </div>
        </div>

        <div class="section">
            <h2>경력</h2>
            <div class="resume-item">
                <div class="resume-header">소프트웨어 엔지니어</div>
                <div class="resume-content">ABC 테크놀로지 (2019 - 2023)</div>
            </div>
        </div>

        <div class="section">
            <h2>희망 근무 조건</h2>
            <div class="resume-item">
                <div class="resume-content">희망 근무지: 동대입구<br>희망 업직종: IT<br>근무형태: 알바<br>근무기간: 1년 이상<br>근무일시: 주5일</div>
            </div>
        </div>
      
        <div class="section">
            <h2>자기소개</h2>
            <div class="resume-item">
                <div class="resume-content">다양한 프로젝트 경험을 보유한 개발자로서, 적극적인 문제 해결 능력을 가지고 있습니다.</div>
            </div>
        </div>

        <div class="section">
            <h2>포트폴리오</h2>
            <div class="resume-item">
                <div class="resume-header">이력서</div>
                <div class="resume-content">파일 없음</div>
            </div>
        </div>
    </div>
    <div class="footer">
    <%@ include file="/WEB-INF/view/common/footer.jsp"%>
    </div>
</body>
</html>
