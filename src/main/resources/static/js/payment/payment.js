document.addEventListener("DOMContentLoaded", function() {
    var IMP = window.IMP;
    IMP.init("imp07567075"); // 올바른 가맹점 식별 코드 사용

    // 상점 고유 주문번호 생성
    var today = new Date();
    var hours = today.getHours(); // 시
    var minutes = today.getMinutes(); // 분
    var seconds = today.getSeconds(); // 초
    var milliseconds = today.getMilliseconds();
    var makeMerchantUid = `${hours}${minutes}${seconds}${milliseconds}`; // 고유한 주문번호 생성

    // 결제 버튼 클릭 이벤트 핸들러 설정
    document.getElementById('payment').onclick = function() {
        var item = 'y'; // 결제 성공 시 item 값은 'y'
        var userId = document.getElementById('payment').getAttribute('data-user-id');
		console.log(userId);
		
        // 결제창 호출
        IMP.request_pay({
            pg: "kakaopay.TC0ONETIME", // 결제 PG사
            pay_method: "card", // 결제 방식
            merchant_uid: makeMerchantUid, // 상점 고유 주문번호
            name: "포트원 테스트", // 상품명
            amount: 15000000, // 결제 금액
            item: item,
        }, function (rsp) { // 결제 응답 처리
            if (rsp.success) { // 결제 성공 시
                console.log(rsp); // 응답값 콘솔에 출력
                // 결제 성공 후 DB에 결제 정보 저장 요청
                savePayment(item, userId);
                alert('결제 완료!');
                window.location.reload(); // 페이지 새로고침
            } else { // 결제 실패 시
                item = 'fail'; // 결제 실패 시 item 값을 'fail'로 설정
                console.log(`결제 실패: ${rsp.error_msg}`); // 실패 메시지 출력
                // 결제 실패 후 DB에 결제 정보 저장 요청
                savePayment(item, userId);
                alert(`결제 실패: ${rsp.error_msg}`);
            }
        });
    };

    // 결제 정보를 DB에 저장하는 함수
	function savePayment(item, userId) {
	    var paymentData = {
	        item: item,
	        userId: userId
	    };

	    fetch('http://localhost:60085/api/payment/updateUserPayStatus', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify(paymentData)
	    })
		.then(response => response.json())  // 응답을 JSON으로 변환
		.then(data => {
		    if (data && data.message === "결제 정보가 성공적으로 저장되었습니다.") {
		        console.log('결제 정보 저장 성공:', data);
		        alert('결제 완료!');
		        window.location.href = "/";  // 페이지 이동
		    }
		})
	}
});
