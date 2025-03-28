<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<!DOCTYPE html>
<html>
<head>
	<title>이력서 작성</title>
<%@ include file="/WEB-INF/view/common/header.jsp" %>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="${contextPath}/css/resume/resume.css">
	<style>
		* {
			font-family: "Noto Sans KR", sans-serif;
		}
	</style>
</head>
<body>
	<script src="${contextPath}/js/resume_write.js"></script>
	<form id="resumeForm" action="/resume/write" method="POST">
	<div class="section">
	<div class="orange-form">
		<h2 class="section-title">이력서 작성</h2>
		<div class="profile-box">
		<div class="profile">
    <button type="button">
        <img id="previewImage" src="https://contents.albamon.kr/monimg/msa/assets/images/icon_profile_male80.svg" alt="프로필 이미지" onclick="imgupload()">
    </button>
    	<input type="file" id="imgInput" style="display: none;" onchange="handleImgUpload(event)">
    	<div class="profile-info">
        	<div class="profile-details">
            	<span class="profile-name" style="margin-bottom: 3px;">${profile.name}</span>
            	<span>남자 25세</span>
            	<span>/ 2000년생</span>
        	</div>
        		<div class="profile-address">
            		<span >주소<span class="section-head__required">*</span><span class="section-margin-left3">서울 동작구 사당1동</span></span>
            		<span class="section-margin-left">이메일</span><span class="section-margin-left3" style="font-size: 16px;">${profile.email}</span>
        		</div>
        		<div>
        			<span style="margin-top:6px;">휴대폰<span class="section-margin-left3">${profile.phone}</span></span>
        		</div>
    		</div>
    		</div>
		</div>
		<h2 class="section-title">
		학력사항
		<span class="section-head__required">*</span>
		</h2>
		<div class="section-line"></div>
		<div class="section-text section-bold section-margin-top">최종학력
		<select name="school" id="" class="section-margin-left2 section-box" tabindex="-1">
			<option value="">학교</option>
			<option value="초등학교">초등학교</option>
			<option value="중학교">중학교</option>
			<option value="고등학교">고등학교</option>
			<option value="대학(2,3년제)">대학(2,3년제)</option>
			<option value="대학(4년제)">대학(4년제)</option>
			<option value="대학원">대학원</option></select>
		<select name ="status" id="" class="section-box" tabindex="-1">
			<option value="">상태</option>
			<option value="졸업">졸업</option>
			<option value="재학">재학</option>
			<option value="휴학">휴학</option>
		</select>
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<h2 class="section-margin-top2 section-title">
		경력사항
		<span class="section-head__required">*</span>
		</h2>
		<div class="section-line"></div>
		<div class="section-text section-bold section-margin-top">경력구분
			<span class="section-margin-left2 section-box-personal-left selected" data-value="신입">신입</span>
			<input type="hidden" name="personal" id="personalHiddenInput" value="신입">
			<span class="section-box-personal-right" data-value="경력">경력</span>
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<h2 class="section-margin-top2 section-title">
		희망근무조건
		<span class="section-head__required">*</span>
		</h2>
		<div class="section-line"></div>
		<div class="section-text section-bold section-margin-top">근무지
		<span class="section-head__required">*</span>
			<select name="work_place_region" id="" class="section-margin-left2 section-box-from" tabindex="-1">
				<option value="">전국</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
				<option value="인천광역시">인천광역시</option>
				<option value="강원특별자치도">강원특별자치도</option>
				<option value="대전광역시">대전광역시</option>
				<option value="세종특별자치시">세종특별자치시</option>
				<option value="충청남도">충청남도</option>
				<option value="충청북도">충청북도</option>
				<option value="부산광역시">부산광역시</option>
				<option value="울산광역시">울산광역시</option>
				<option value="세종특별자치시">세종특별자치시</option>
				<option value="경상남도">경상남도</option>
				<option value="경상북도">경상북도</option>
				<option value="대구광역시">대구광역시</option>
				<option value="광주광역시">광주광역시</option>
				<option value="전라남도">전라남도</option>
				<option value="전북특별자치도">전북특별자치도</option>
				<option value="제주특별자치도">제주특별자치도</option></select>
			<select name="work_place_city" id="" class="section-box-from" tabindex="-1">
				<option value="">시/군/구</option>
				<option value="전체">전체</option>
			</select>
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<div class="section-text section-bold section-margin-top">업직종
		<span class="section-head__required">*</span>
			<select name="industry_occupation" id="" class="section-margin-left2 section-box-from" tabindex="-1">
				<option value="">선택</option>
				<option value="서비스">서비스</option>
				<option value="사무직">사무직</option>
				<option value="IT">IT기술</option>
				<option value="디자인">디자인</option></select>
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<div class="section-text section-bold section-margin-top">근무형태
		<span class="section-head__required">*</span>
			<input type="checkbox" class="section-margin-left" id="part_time_job" name="employmentType" value="알바" onclick="checkOnlyOne(this)">알바
			<input type="checkbox"id="full_time_worker" name="employmentType" value="정규직" onclick="checkOnlyOne(this)">정규직
			<input type="checkbox"id="contract_worker" name="employmentType" value="계약직" onclick="checkOnlyOne(this)">계약직
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<div class="section-text section-bold section-margin-top">근무기간
			<select name="working_period" id="" class="section-margin-left2 section-box-from" tabindex="-1">
				<option value="무관">무관</option>
				<option value="하루">하루</option>
				<option value="1주일이하">1주일이하</option>
				<option value="1개월 ~ 3개월">1개월 ~ 3개월</option>
				<option value="3개월 ~ 6개월">3개월 ~ 6개월</option>
				<option value="6개월 ~ 1년">6개월 ~ 1년</option>
				<option value="1년 이상">1년 이상</option>
				</select>
		</div>
		
		<div class="section-line-gry section-margin-top"></div>
		<div class="section-text section-bold section-margin-top">근무일시
			<select name="working_day" id="" class="section-margin-left2 section-box-from" tabindex="-1">
				<option value="무관">무관</option>
				<option value="주1일">주1일</option>
				<option value="주2일">주2일</option>
				<option value="주3일">주3일</option>
				<option value="주4일">주4일</option>
				<option value="주5일">주5일</option>
				<option value="주6일">주6일</option>
				<option value="주7일">주7일</option>
				</select>
		</div>
		<div class="section-line-gry section-margin-top"></div>
		
		<h2 class="section-margin-top2 section-title">
		자기소개
		<span class="section-head__required">*</span>
		</h2>
		<div class="section-line"></div>
		<div class="section-text section-bold section-margin-top">자기소개
		<span class="section-head__required">*</span>
			<textarea class="section-margin-left section-textarea" id="introduction" name="introduction" placeholder="자기소개를 입력해 주세요.(최소 20자 필수)" rows="5"></textarea>
		</div>
		
		
		<div class="section-line-gry section-margin-top"></div>
		
		<h2 class="section-margin-top2 section-title">
		포트폴리오
		</h2>
		<div class="section-line"></div>
		<table id="portfolioTable" style="width: 100%; table-layout: fixed; border-collapse: collapse;">
			<thead>
				<tr>
					<th id="title" style="width: 450px; text-align: center;">포트폴리오제목</th>
					<th id="date" style="width: 200px; text-align: center;">등록일</th>
					<th id="volume" style="width: 280px; text-align: center;">용량</th>
				</tr>
				
   					<tr>
        				<td class="section-line-gry-plus" style="padding-bottom: 15px;"></td>
    				</tr>
				
			</thead>
			<tbody id="portfolioTableBody">
			
			</tbody>
		</table>
		
		
		<div align="center" class="empty-portfolio" id="emptyMessage">등록된 포트폴리오가 없습니다.</div>
		<div class="center-container">
		<button id="portfolio" type="button" class="empty-portfolio-btn" onclick="fileupload()">포트폴리오 추가</button>
		<input type="file" id="fileInput" style="display: none;" onchange="handleFileUpload(event)">
		</div>
		<div class="section-line-gry section-margin-top"></div>
		<div class="center-container">
    <div class="agreement-box">
        <label class="checkbox-container">
            <input type="checkbox">
            <span class="checkmark"></span>
            개인정보 수집 및 이용안내(필수, 선택)에 모두 동의합니다.
        </label>

        <div class="sub-agreements">
            <label class="checkbox-container">
                <input type="checkbox">
                <span class="checkmark"></span>
                <span class="required">(필수)</span> 개인정보수집 및 이용 동의
            </label>

            <label class="checkbox-container">
                <input type="checkbox">
                <span class="checkmark"></span>
                <span class="optional">(선택)</span> 개인정보수집 및 이용 동의
            </label>
        </div>
    </div>
	</div>
	</div>
	</div>
    <div class="button-container">
        <button class="temp-save">
            <span class="loading-icon"></span> 임시 저장
        </button>
        <button type="submit" class="save">
            이력서 저장
        </button>
    </div>
	
	</form>
	<%@ include file="/WEB-INF/view/common/footer.jsp" %>
</body>
</html>