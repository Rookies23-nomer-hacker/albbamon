<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일주일 달력</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .today {
            background-color: #ffeb3b;  /* 노란 배경 */
            color: blue;              /* 글자 색을 파란색으로 */
            font-weight: bold;         /* 글씨 굵게 */
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2); /* 테두리 그림자 효과 */
        }
        .day-cell {
            height: 100px;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #ddd; /* 모든 방향에 테두리 적용 */
            font-size: 18px;
        }
        .calendar-table-wrapper {
            overflow-x: auto; /* 화면이 좁을 때 스크롤을 추가 */
        }
        table {
            table-layout: auto; /* 테이블의 레이아웃을 자동으로 설정 */
            width: 100%; /* 테이블 너비를 100%로 설정 */
        }
    </style>
</head>
<body>

<div class="container my-5">
    <h2 class="mb-4">일주일 달력</h2>

    <div class="row">
        <!-- 일주일 달력 -->
        <div class="col-12 calendar-table-wrapper">
            <table class="table table-bordered text-center">
                <thead>
                    <tr>
                        <th class="day-cell">월</th>
                        <th class="day-cell">화</th>
                        <th class="day-cell">수</th>
                        <th class="day-cell">목</th>
                        <th class="day-cell">금</th>
                        <th class="day-cell">토</th>
                        <th class="day-cell">일</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <!-- 일주일 날짜가 동적으로 표시될 부분 -->
                        <td class="day-cell" id="mon"></td>
                        <td class="day-cell" id="tue"></td>
                        <td class="day-cell" id="wed"></td>
                        <td class="day-cell" id="thu"></td>
                        <td class="day-cell" id="fri"></td>
                        <td class="day-cell" id="sat"></td>
                        <td class="day-cell" id="sun"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // 오늘 날짜 가져오기
    const today = new Date();
    const dayOfWeek = today.getDay(); // 일요일: 0, 월요일: 1, ... 토요일: 6
    const currentDate = today.getDate();

    // 일주일의 시작 날짜 구하기 (오늘을 기준으로 일주일의 시작일이 월요일일 경우)
    const firstDayOfWeek = new Date(today);
    firstDayOfWeek.setDate(currentDate - dayOfWeek ); // 월요일 날짜

    // 날짜를 표시할 셀의 id
    const dayCells = {
        1: 'mon', 2: 'tue', 3: 'wed', 4: 'thu', 5: 'fri', 6: 'sat', 0: 'sun'
    };

    // 각 날짜 셀에 날짜 채우기
    Object.keys(dayCells).forEach((dayIndex) => {
        const cellId = dayCells[dayIndex];
        const dayDate = new Date(firstDayOfWeek);
        dayDate.setDate(firstDayOfWeek.getDate() + parseInt(dayIndex));
        
        // 해당 날짜 채우기
        const dayCell = document.getElementById(cellId);
        dayCell.innerHTML = dayDate.getDate();

        // 오늘 날짜 강조
        if (dayDate.toDateString() === today.toDateString()) {
            dayCell.classList.add('today');
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
