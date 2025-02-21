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
        var buyer_name = document.getElementById('buyer_name').value;
        var buyer_email = document.getElementById('buyer_email').value;
        var buyer_tel = document.getElementById('buyer_tel').value;
        var buyer_addr = document.getElementById('buyer_addr').value;
        var buyer_post_code = document.getElementById('buyer_post_code').value;

        // 결제창 호출
        IMP.request_pay({
            pg: "kakaopay.TC0ONETIME", // 결제 PG사
            pay_method: "card", // 결제 방식
            merchant_uid: makeMerchantUid, // 상점 고유 주문번호
            name: "포트원 테스트", // 상품명
            amount: 1004, // 결제 금액
            buyer_email: buyer_email, // 입력한 이메일
            buyer_name: buyer_name, // 입력한 이름
            buyer_tel: buyer_tel, // 입력한 전화번호
            buyer_addr: buyer_addr, // 입력한 주소
            buyer_post_code: buyer_post_code, // 입력한 우편번호
        }, function (rsp) { // 결제 응답 처리
            if (rsp.success) { // 결제 성공 시
                console.log(rsp); // 응답값 콘솔에 출력
				// 결제 성공 후 DB에 결제 정보 저장 요청
				savePayment(buyer_name, buyer_email, buyer_tel, buyer_addr, buyer_post_code);
                // DB 저장 성공 시
                if (rsp.status === 200) {
                    alert('결제 완료!');
                    window.location.reload(); // 페이지 새로고침
                } else { // DB 저장 실패 시
                    alert(`Error: [${rsp.status}]\n결제 요청이 승인된 경우 관리자에게 문의 바랍니다.`);
                    // DB 저장 실패 시 추가 작업
                }
            } else { // 결제 실패 시
                alert(`결제 실패: ${rsp.error_msg}`); // 실패 메시지 출력
            }
        });
    };
	// 결제 정보를 DB에 저장하는 함수
	function savePayment(buyer_name, buyer_email, buyer_tel, buyer_addr, buyer_postcode) {
	    var paymentData = {
	        buyerName: buyer_name,
	        buyerEmail: buyer_email,
	        buyerTel: buyer_tel,
	        buyerAddr: buyer_addr,
	        buyerPostcode: buyer_postcode
	    };

	    fetch('http://localhost:60085/api/payment/save', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/json'
	        },
	        body: JSON.stringify(paymentData)
	    })
	    .then(response => response.json())
		.then(data => {
		    console.log('결제 정보 저장 성공:', data);
		    if (data.message === "결제 정보가 성공적으로 저장되었습니다.") {
		        // 결제 성공 처리
		        alert('결제 완료!');
		        window.location.href("../main/main");
		    }
		})
		.catch(error => {
		    console.error('결제 정보 저장 실패:', error);
		});
	}
});
