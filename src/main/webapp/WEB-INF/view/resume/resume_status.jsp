<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지원현황</title>
    <style>
        * {
            font-family: "Noto Sans KR", sans-serif;
        }
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #ffffff;
            padding: 20px;
        }
        .container {
            width: 900px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 2px solid #ff6600;
        }
        .header {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .info {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
        }
        .status-container {
            display: flex;
            justify-content: space-around;
            padding: 10px;
            background: #f8f8f8;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .status-box {
            text-align: center;
        }
        .status-number.total {
            font-size: 24px;
            font-weight: bold;
            color: #ff6600;
        }
        .status-number {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .status-label {
            font-size: 14px;
            color: #666;
        }
        .tab-menu {
            display: flex;
            border-bottom: 2px solid #ddd;
            margin-bottom: 20px;
        }
        .tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            font-weight: bold;
        }
        .tab.active {
            border-bottom: 2px solid #ff6600;
            color: #ff6600;
        }
        .job-list {
            margin-top: 20px;
        }
        .job-item {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }
        .job-title {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
        .job-meta {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        .actions {
            margin-top: 10px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            font-size: 12px;
            cursor: pointer;
        }
        .btn-orange {
            background-color: #ff6600;
            color: white;
        }
        .btn-gray {
            background-color: #ddd;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">지원현황</div>
        <div class="info">최근 1년 이내의 지원내역을 확인할 수 있습니다.</div>
        <div class="status-container">
            <div class="status-box">
                <div class="status-number total">0</div>
                <div class="status-label">전체</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">지원완료</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">면접</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">합격</div>
            </div>
            <div class="status-box">
                <div class="status-number">0</div>
                <div class="status-label">불합격/취소</div>
            </div>
        </div>
        <div class="tab-menu">
            <div class="tab active">온라인·문자·이메일 지원</div>
            <div class="tab">기타 지원</div>
            <div class="tab">숨긴내역</div>
        </div>
        <div class="job-list">
            <div class="job-item">
                <div class="job-title">더먼 푸드 - 중앙대학교 광명병원 푸드트럭 배식 알바</div>
                <div class="job-meta">2024.06.27 | 간편문자지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">케이제이 - 중앙대학교 광명병원 연수강좌 운영요원 아르바이트</div>
                <div class="job-meta">2024.06.06 | 온라인지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">케이제이 - 중앙대학교 광명병원 연수강좌 운영요원 아르바이트</div>
                <div class="job-meta">2024.06.06 | 온라인지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">케이제이 - 중앙대학교 광명병원 연수강좌 운영요원 아르바이트</div>
                <div class="job-meta">2024.06.06 | 온라인지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">케이제이 - 중앙대학교 광명병원 연수강좌 운영요원 아르바이트</div>
                <div class="job-meta">2024.06.06 | 온라인지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
            <div class="job-item">
                <div class="job-title">케이제이 - 중앙대학교 광명병원 연수강좌 운영요원 아르바이트</div>
                <div class="job-meta">2024.06.06 | 온라인지원 | 마감</div>
                <div class="actions">
                    <button class="btn btn-gray">기업후기 작성하기</button>
                    <button class="btn btn-orange">메모하기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
