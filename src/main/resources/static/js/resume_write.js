
		function checkOnlyOne(clickedCheckbox){
			// 모든 체크박스를 가져옴
		    const checkboxes = document.getElementsByName("employmentType");

		    // 현재 클릭된 체크박스를 제외하고 모든 체크박스 해제
		    checkboxes.forEach((checkbox) => {
		        if (checkbox !== clickedCheckbox) {
		            checkbox.checked = false;
		        }
		    });//
		}
		function fileupload() {

		    const fileInput = document.getElementById('fileInput');
		    if (!fileInput) {
		        alert("파일 입력 요소를 찾을 수 없습니다."); // 예외 처리
		        return;
		    }
		    fileInput.click(); // 숨겨진 파일 선택창을 클릭하도록 유도
		}
		function handleFileUpload(event) {
		    const file = event.target.files[0]; // 사용자가 선택한 파일 가져오기
		    if (file) {
		        // 기존 파일 삭제 (포트폴리오 목록 초기화)
		        const tableBody = document.getElementById('portfolioTableBody');
		        tableBody.innerHTML = ""; // 테이블 비우기

		        // 기존 hidden input 제거
		        document.querySelectorAll("input[name='portfolioData'], input[name='portfolioName']").forEach(input => input.remove());

		        const reader = new FileReader();
		        reader.onload = function (e) {
		            const file_base64 = e.target.result.split(',')[1]; // Base64 데이터 추출
		            const uploadDate = new Date().toISOString().split('T')[0]; // YYYY-MM-DD 형식
		            const fileSize = (file.size / 1024).toFixed(2) + ' KB'; // KB 단위 변환
		            const emptyMessage = document.getElementById('emptyMessage');

		            // 테이블 보이도록 설정
		            document.getElementById('portfolioTable').style.display = 'table';

		            if (emptyMessage) {
		                emptyMessage.style.display = 'none';
		            }

		            // 테이블에 파일 정보 추가
		            const newRow = tableBody.insertRow();

		            const titleCell = newRow.insertCell(0);
		            titleCell.textContent = file.name;
		            titleCell.style.width = "630px";
		            titleCell.style.height = "70px";
		            titleCell.style.textAlign = "center";
		            titleCell.style.overflow = "hidden";
		            titleCell.style.textOverflow = "ellipsis";
		            titleCell.style.whiteSpace = "nowrap";

		            const dateCell = newRow.insertCell(1);
		            dateCell.textContent = uploadDate;
		            dateCell.style.width = "200px";
	            	dateCell.style.height = "70px";
		            dateCell.style.textAlign = "center";

		            const sizeCell = newRow.insertCell(2);
		            sizeCell.textContent = fileSize;
		            sizeCell.style.width = "200px";
		            sizeCell.style.height = "70px";
		            sizeCell.style.textAlign = "center";

		            // Hidden input에 Base64 데이터 저장 (폼 전송 시 사용)
		            const hiddenInput_data = document.createElement("input");
		            hiddenInput_data.type = "hidden";
		            hiddenInput_data.name = "portfolioData";
		            hiddenInput_data.value = file_base64;
		            document.getElementById("resumeForm").appendChild(hiddenInput_data);

		            // Hidden input에 파일 이름 저장 (폼 전송 시 사용)
		            const hiddenInput_name = document.createElement("input");
		            hiddenInput_name.type = "hidden";
		            hiddenInput_name.name = "portfolioname";
		            hiddenInput_name.value = file.name;
		            document.getElementById("resumeForm").appendChild(hiddenInput_name);
		        };

		        reader.readAsDataURL(file); // 파일 읽기
		    }
		}
		function imgupload() {

				    const fileInput = document.getElementById('imgInput');
				    if (!fileInput) {
				        alert("파일 입력 요소를 찾을 수 없습니다."); // 예외 처리
				        return;
				    }
				    fileInput.click(); // 숨겨진 파일 선택창을 클릭하도록 유도
				}
				function handleImgUpload(event) {
				    const file = event.target.files[0]; // 사용자가 선택한 파일 가져오기
				    if (file) {
						document.querySelectorAll("input[name='resume_img_data'], input[name='resume_img_name']").forEach(input => input.remove());
				        const reader = new FileReader();
				        reader.onload = function (e) {
				            // 전체 data URL을 이미지 미리보기로 표시
				            document.getElementById('previewImage').src = e.target.result;

				            // Base64 데이터 추출 (hidden input 전송용)
				            const file_base64 = e.target.result.split(',')[1];

				            // Hidden input에 Base64 데이터 저장 (폼 전송 시 사용)
				            const hiddenInput_data = document.createElement("input");
				            hiddenInput_data.type = "hidden";
				            hiddenInput_data.name = "resume_img_data";
				            hiddenInput_data.value = file_base64;
				            document.getElementById("resumeForm").appendChild(hiddenInput_data);

				            // Hidden input에 파일 이름 저장 (폼 전송 시 사용)
				            const hiddenInput_name = document.createElement("input");
				            hiddenInput_name.type = "hidden";
				            hiddenInput_name.name = "resume_img_name";
				            hiddenInput_name.value = file.name;
				            document.getElementById("resumeForm").appendChild(hiddenInput_name);
				        };

				        reader.readAsDataURL(file); // 파일 읽기
				    }
				}

document.addEventListener("DOMContentLoaded", function () {
	document.getElementById("resumeForm").addEventListener("submit", function (event) {
		const school = document.querySelector("select[name='school']").value;
		const status = document.querySelector("select[name='status']").value; 
		const personal = document.querySelector("input[name='personal']").value; 
		const work_place_region = document.querySelector("select[name='work_place_region']").value; 
		const work_place_city = document.querySelector("select[name='work_place_city']").value; 
		const industry_occupation = document.querySelector("select[name='industry_occupation']").value; 
		const employmentType = document.querySelector("input[name='employmentType']:checked") 
		    ? document.querySelector("input[name='employmentType']:checked").value 
		    : null;
		const working_period = document.querySelector("select[name='working_period']").value; 
		const working_day = document.querySelector("select[name='working_day']").value; 
		const introduction = document.querySelector("textarea[name='introduction']")
		    ? document.querySelector("textarea[name='introduction']").value 
		    : null;
			
		const profileImg = document.getElementById("previewImage").src;
		const defaultProfileImg = "https://contents.albamon.kr/monimg/msa/assets/images/icon_profile_male80.svg"; // 기본 이미지 URL
		if (profileImg === defaultProfileImg) {
			alert("프로필 사진을 등록해주세요!");
			event.preventDefault();
			return;
		}

		if (!school||!status||!personal||!work_place_region||!work_place_city||!industry_occupation||!employmentType||!working_period||!working_day||!introduction) {
			alert("이력서를 제대로 입력해주세요!"); 
			event.preventDefault();
		}
	});
});
