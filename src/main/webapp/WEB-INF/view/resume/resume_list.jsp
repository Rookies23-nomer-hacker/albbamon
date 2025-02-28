<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<html>
<head>
    <title>Resume List</title>
</head>
<body>

<h1>Resume List</h1>

<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container mt-4">
    <c:forEach var="resume" items="${resumes}">
        <div class="card mb-4" style="border: 1px solid rgb(215, 220, 250); background-color: rgb(253, 253, 255);">
            <a href="${resume.portfoliourl}" class="text-decoration-none">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="profile-avatar">${resume.resume_imgurl}${resume_img_name}
                            <!-- Check if resume.resume_imgurl is not null or empty -->
                            <img src="${empty resume.resume_imgurl ? 'https://example.com/default-profile-img.jpg' : resume.resume_imgurl}" alt="Profile" class="rounded-circle" style="width: 56px; height: 56px;">
                        </div>
                        <div class="ms-3">
                            <!-- Check if resume.personal is not null or empty -->
                            <p class="m-0 text-muted">${empty resume.personal ? '정보 없음' : resume.personal}</p>
                            <h5 class="m-0">${empty resume.personal ? '이름 없음' : resume.personal} (남, 42세)</h5> <!-- Example: You can change based on actual data -->
                        </div>
                    </div>
                    <div class="d-flex justify-content-between mt-3">
                        <div class="text-muted">
                            <i class="bi bi-geo-alt" style="font-size: 18px;"></i>
                            ${empty resume.work_place_region ? '위치 정보 없음' : resume.work_place_region}, ${empty resume.work_place_city ? '위치 정보 없음' : resume.work_place_city}
                        </div>
                        <div class="text-muted">
                            <i class="bi bi-briefcase" style="font-size: 18px;"></i>
                            ${empty resume.industry_occupation ? '산업 정보 없음' : resume.industry_occupation}
                        </div>
                    </div>
                    <div class="mt-2">
                        <span class="badge bg-primary me-2">${empty resume.school ? '학교 정보 없음' : resume.school}</span> <!-- Example: Add more as needed -->
                        <span class="badge bg-primary me-2">${empty resume.employmentType ? '고용 유형 정보 없음' : resume.employmentType}</span>
                        <span class="badge bg-secondary">+1</span>
                    </div>
                    <div class="mt-3 text-muted">
                        <span>${empty resume.introduction ? '자기소개 없음' : resume.introduction}</span>
                        <span class="ms-3">${empty resume.working_period ? '근무 기간 정보 없음' : resume.working_period}</span>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>

</body>
</html>
