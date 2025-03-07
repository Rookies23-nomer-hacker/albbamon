<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스페셜 인재</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            font-family: "Noto Sans KR", sans-serif;
        }
        .btn-primary {
            background-color: #FF6600 !important; /* 버튼 배경 색상 */
            border-color: #FF6600 !important;
            border-radius: 10px !important;
        }

        .btn-primary:hover {
            background-color: #ff501b !important;
            border-color: #e55a00 !important;
        }
        .badge.bg-primary {
        	--bs-bg-opacity: 1;
    		background-color: #FF6600 !important;
        }
        .border-primary {
		    border-color: #ff501b !important; /* 원하는 색상 코드 */
		}

    </style>
</head>
<body>
	<%@ include file="/WEB-INF/view/common/header.jsp" %>

<div class="container mt-5">
    <!-- 타이틀 영역 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">스페셜 인재</h2>
        <button type="button" class="btn btn-primary">
			<a href="/resume/write" class="btn btn-primary">
				이력서 올리기
			</a><i class="bi bi-arrow-right"></i>
		</button>
    </div>

    <!-- 이력서 목록 -->
    <div class="row">
        <c:forEach var="resume" items="${resumes}">
            <c:choose>
                <c:when test="${empty resume.resume_imgurl}">
                    <c:set var="profileImg" value="${contextPath}/img/profile.png"/>
                </c:when>
                <c:otherwise>
                    <c:set var="profileImg" value="${resume.resume_imgurl}${resume.resume_img_name}"/>
                </c:otherwise>
            </c:choose>
            <c:set var="resumeId" value="${resume.resume_id}" />
            <c:set var="personalName" value="${empty resume.personal ? '이름 없음' : resume.personal}" />
            <c:set var="location" value="${empty resume.work_place_region ? '위치 정보 없음' : resume.work_place_region}, ${empty resume.work_place_city ? '위치 정보 없음' : resume.work_place_city}" />
            <c:set var="industry" value="${empty resume.industry_occupation ? '산업 정보 없음' : resume.industry_occupation}" />
            <c:set var="schoolInfo" value="${empty resume.school ? '학교 정보 없음' : resume.school}" />
            <c:set var="employmentTypeInfo" value="${empty resume.employmentType ? '고용 유형 정보 없음' : resume.employmentType}" />
            <c:set var="intro" value="${empty resume.introduction ? '자기소개 없음' : resume.introduction}" />
            <c:set var="workingPeriod" value="${empty resume.working_period ? '근무 기간 정보 없음' : resume.working_period}" />
            <c:set var="workingDay" value="${empty resume.working_day ? '근무 요일 정보 없음' : resume.working_day}" />
            <c:set var="portfolioName" value="${empty resume.portfolioname ? '포트폴리오 없음' : resume.portfolioname}" />
            <c:set var="portfolioUrl" value="${empty resume.portfoliourl ? '#' : resume.portfoliourl}" />
            <c:set var="resumeImgName" value="${empty resume.resume_img_name ? '' : resume.resume_img_name}" />

            <div class="col-md-4 mb-4">
                <div class="card h-100 border-primary bg-light" style="border-color:#ff501b !important;">
                    <div class="card-body" style="padding: 30px">
                        <!-- 프로필 사진 및 기본 정보 -->
                        <div class="d-flex align-items-center">
                            <img src="${profileImg}" class="rounded-circle me-3" style="width: 56px; height: 56px;" alt="Profile"
                                title="${resumeImgName}">
                            <div>
                                <p class="m-0 text-muted">${personalName}</p>
                                <h5 class="m-0">${personalName}</h5>
                            </div>
                        </div>

                        <!-- 위치 및 산업 정보 -->
                        <div class="mt-3 text-muted">
                            <i class="bi bi-geo-alt"></i> ${location}
                        </div>
                        <div class="mt-1 text-muted">
                            <i class="bi bi-briefcase"></i> ${industry}
                        </div>

                        <!-- 추가 정보 (학교, 고용 형태, 근무 요일) -->
                        <div class="mt-2">
                            <span class="badge bg-primary">${schoolInfo}</span>
                            <span class="badge bg-primary">${employmentTypeInfo}</span>
                            <span class="badge bg-secondary">${workingDay}</span>
                        </div>

                        <!-- 자기소개 및 근무 기간 -->
                        <div class="mt-3 text-muted">
                            <span>${intro}</span>
                            <span class="ms-3">${workingPeriod}</span>
                        </div>

                        <!-- 포트폴리오 링크 -->
                        <div class="mt-3" style="border-color:#ff501b !important;">
                            <div href="${portfolioUrl}${portfolioName}" target="_blank" class="btn btn-outline-primary btn-sm ${portfolioUrl == '#' ? 'disabled' : ''}" style="border-color:#ff501b !important; color: #ff501b !important;"
                            onmouseover="this.style.backgroundColor='#ff501b'; this.style.color='white';" onmouseout="this.style.backgroundColor='white'; this.style.color='#ff501b';">
                                포트폴리오 보기 (${fn:substring(portfolioName, 0, fn:indexOf(portfolioName, '.') - 15)}${fn:substring(portfolioName, fn:indexOf(portfolioName, '.'), fn:length(portfolioName))})
                            </div>
                        </div>

                        <!-- 이력서 개별 조회 -->
                        <div class="mt-3">
                            <a href="/resume/view?resumeId=${resumeId}" class="btn btn-outline-secondary btn-sm">
                                이력서 상세 보기
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="/WEB-INF/view/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
