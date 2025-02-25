
document.addEventListener("DOMContentLoaded", function () {
	if(duplicated==("이미 이력서가 있습니다.")){
			alert("이미 이력서가 있습니다.")
	}else{
		alert("이력서 작성 완료!")
	}
	

    
	
    // 테이블 body 요소 가져오기
    let tableBody = document.getElementById("portfolioTableBody");
    let emptyMessage = document.getElementById("emptyMessage");

    // 기존 내용 삭제
    tableBody.innerHTML = "";
    


    if (resumePersonal && resumePersonal.trim() !== "") {
        // 기존의 빈 메시지를 숨김
        emptyMessage.style.visibility = "hidden";
        emptyMessage.style.opacity = "0";

        // 🟢 새로운 행을 만들어 회색 줄 추가
        let greyRow = tableBody.insertRow();
        greyRow.classList.add("grey-row"); // CSS에서 margin-top을 적용하기 위해 클래스 추가
        let greyCell = greyRow.insertCell(0);
        greyCell.colSpan = 5; // 5개의 열 전체를 차지
        let sectionLine = document.createElement("div");
        sectionLine.classList.add("section-line-gry");
        greyCell.appendChild(sectionLine);

        // 실제 데이터 행 추가
        let newRow = tableBody.insertRow();

        let cell1 = newRow.insertCell(0);
        cell1.innerHTML = resumePersonal + "<br><span style='color: gray; font-size: 14px; margin-left: 22px;'>" + resumeWork_place_region + "</span><br><span style='color: gray; font-size: 14px; margin-left: 9px;'>" + resumeIntroduction + "</span>";
        cell1.style.textAlign = "center";

        let cell2 = newRow.insertCell(1);
        cell2.textContent = "2024-02-20";
        cell2.style.textAlign = "center";

        let cell3 = newRow.insertCell(2);
        cell3.style.textAlign = "center";

        // 🟢 버튼을 감쌀 div 생성 (세로 정렬용)
        let buttonContainer = document.createElement("div");
		buttonContainer.style.display = "flex";
		buttonContainer.style.flexDirection = "column";
		buttonContainer.style.gap = "5px"; // 버튼 간격 추가
		buttonContainer.style.alignItems = "center";  // 🟢 버튼을 세로 중앙 정렬
		buttonContainer.style.justifyContent = "center";  // 🟢 버튼을 가로 중앙 정렬
		buttonContainer.style.width = "100%";  // 🟢 부모 셀 전체를 차지
		
        // "수정" 버튼
        let editBtn = document.createElement("button");
        editBtn.textContent = "수정";
        editBtn.classList.add("manage-btn");
        editBtn.style.width = "70px";   // 버튼 너비 조정
        editBtn.style.height = "35px";  // 버튼 높이 조정
        editBtn.style.fontSize = "14px"; // 글씨 크기 조정
        editBtn.style.display = "flex";  
        editBtn.style.alignItems = "center";  // 수직 중앙 정렬
        editBtn.style.justifyContent = "center";//수평

        // "삭제" 버튼
        let deleteBtn = document.createElement("button");
        deleteBtn.textContent = "삭제";
        deleteBtn.classList.add("manage-btn");
        deleteBtn.style.width = "70px";
        deleteBtn.style.height = "35px";
        deleteBtn.style.fontSize = "14px";
        deleteBtn.style.display = "flex";
        deleteBtn.style.alignItems = "center";  // 수직 중앙 정렬
        deleteBtn.style.justifyContent = "center";  // 수평 중앙 정렬
		deleteBtn.addEventListener("click", function() {
				    window.location.href = base_url+"/api/resume/delete";});

        // 버튼을 컨테이너에 추가
        buttonContainer.appendChild(editBtn);
        buttonContainer.appendChild(deleteBtn);

        // 버튼 컨테이너를 셀에 추가
        cell3.appendChild(buttonContainer);

        let cell4 = newRow.insertCell(3);
        cell4.textContent = "공개";
        cell4.style.textAlign = "center";

        let cell5 = newRow.insertCell(4);
        cell5.textContent = "O";
        cell5.style.textAlign = "center";
		
		// 🟢 새로운 행을 만들어 **데이터 아래**에 회색 줄 추가
		   let greyRowBottom = tableBody.insertRow();
		   greyRowBottom.classList.add("grey-row-bottom");
		   let greyCellBottom = greyRowBottom.insertCell(0);
		   greyCellBottom.colSpan = 5;
		   
		   let sectionLineBottom = document.createElement("div");
		   sectionLineBottom.classList.add("section-line-gry");
		   greyCellBottom.appendChild(sectionLineBottom);
    }
	 else {
        emptyMessage.style.visibility = "visible";
        emptyMessage.style.opacity = "1";
    }

});