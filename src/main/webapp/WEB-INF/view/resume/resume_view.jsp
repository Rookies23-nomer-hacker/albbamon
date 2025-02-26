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
            width: 150px; /* 원 크기 지정 */
    		height: 150px; /* 원 크기 지정 */
    		border-radius: 50%; /* 원형 이미지 */
    		overflow: hidden; /* 넘치는 부분 숨기기 */
    		display: flex;
    		justify-content: center;
    		align-items: center;
        }
        .profile-photo img {
    		width: 100%; /* 부모 요소 크기에 맞게 조정 */
    		height: 100%; /* 부모 요소 크기에 맞게 조정 */
    		object-fit: cover; /* 이미지를 잘라서 꽉 차게 맞춤 */
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
        <br>
        <div class="profile-container">
            <div class="profile-photo"><img src=${img} alt="프로필 이미지"></div>
            <div class="profile-info">
                <p><strong>이름:</strong> ${user.name}</p>
                <p><strong>나이:</strong> 25세 (1999년생)</p>
                <p><strong>주소:</strong> 서울특별시 강남구</p>
                <p><strong>이메일:</strong> ${user.email}</p>
                <p><strong>휴대폰 번호:</strong> ${user.phone}</p>
            </div>
        </div>

        <div class="section">
            <h2>학력</h2>
            <div class="resume-item">
                <div class="resume-header">${resume.school} ${resume.status}</div>
                <div class="resume-content">서울대학교 컴퓨터공학과 (2015 - 2019)</div>
            </div>
        </div>

        <div class="section">
            <h2>경력</h2>
            <div class="resume-item">
                <div class="resume-header">${resume.personal}</div>
                <!--  <div class="resume-content">ABC 테크놀로지 (2019 - 2023)</div>-->
            </div>
        </div>

        <div class="section">
            <h2>희망 근무 조건</h2>
            <div class="resume-item">
                <div class="resume-content">희망 근무지: ${resume.work_place_region}<br>희망 업직종: ${resume.industry_occupation}<br>근무형태: ${resume.employmentType}<br>근무기간: ${resume.working_period}<br>근무일시: ${resume.working_day}</div>
            </div>
        </div>
      
        <div class="section">
            <h2>자기소개</h2>
            <div class="resume-item">
                <div class="resume-content">${resume.introduction}</div>
            </div>
        </div>

    <div class="section">
    <h2>포트폴리오</h2>
    <div class="resume-item">
        <div class="resume-content">
            <c:choose>
                <c:when test="${empty resume.portfolioname}">
                    파일 없음
                </c:when>
                <c:otherwise>
                    <a href="${api_url}/api/resume/download?fileName=${resume.portfolioname}"
                       style="text-decoration: none; color: inherit; display: flex; align-items: center;"
                       download>
                        <img src="https://cdn-icons-png.flaticon.com/512/2991/2991108.png"
                             alt="파일 아이콘" width="20" height="20" style="margin-right: 5px;">
                        <span>${file}</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

        </div>
    </div>
    <div class="footer">
    <%@ include file="/WEB-INF/view/common/footer.jsp"%>
    </div>
</body>
</html>
