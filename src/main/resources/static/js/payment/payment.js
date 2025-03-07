document.addEventListener("DOMContentLoaded", function() {
    var IMP = window.IMP;
    IMP.init("imp07567075"); // 올바른 가맹점 식별 코드 사용

    // 상점 고유 주문번호 생성
    var today = new Date();
    var hours = today.getHours(); 
    var minutes = today.getMinutes(); 
    var seconds = today.getSeconds(); 
    var milliseconds = today.getMilliseconds();
    var makeMerchantUid = `${hours}${minutes}${seconds}${milliseconds}`;

    // 결제 버튼 클릭 이벤트 핸들러 설정
    document.getElementById('payment').onclick = function() {
        var userId = document.getElementById('payment').getAttribute('data-user-id');
        console.log("유저 ID:", userId);

        // 결제창 호출
        IMP.request_pay({
            pg: "kakaopay.TC0ONETIME",
            pay_method: "card",
            merchant_uid: makeMerchantUid,
            name: "포트원 테스트",
            amount: 1500000
        }, function (rsp) { 
            console.log("결제 응답:", rsp); // 응답 로그 확인
            
            let item = null; // 변수를 함수 내부에서 선언 (불필요한 전역 상태 변경 방지)

            // 먼저 `rsp.error_msg`를 확인하여 결제 취소 또는 실패를 판단
            if (rsp.error_msg && rsp.error_msg.includes("결제포기")) { 
                item = 'fail'; // ✅ 결제 취소 시 'fail'로 설정
                console.log("결제 취소됨:", rsp.error_msg);
            } 
            else if (!rsp.success) { 
                item = 'fail'; // 결제 실패 시 'fail'로 설정
                console.log("결제 실패:", rsp.error_msg);
            } 
            else { 
                item = 'Y'; // 결제 성공 시 'Y'로 설정
                console.log("결제 성공!");
            }

            // item 값이 올바르게 설정되었는지 확인 후 저장
            console.log("DB 저장 전 item 값:", item); // 🔹 이 부분으로 디버깅 가능
            savePayment(item, userId);

            // 결제 상태에 따라 페이지 이동
            if (item === 'Y') {
                alert('결제 완료!');
                window.location.href = `${base_url}/payment/success`;
            } else {
                alert(`결제 실패 또는 취소: ${rsp.error_msg}`);
                window.location.href = `${base_url}/payment/fail`;
            }
        });
    };

    // 결제 정보를 DB에 저장하는 함수
    function savePayment(item, userId) {
        console.log("savePayment() 호출됨. 저장할 item 값:", item);

        var paymentData = {
            item: item,
            userId: userId
        };
        fetch(`${apiBaseUrl}/api/payment/updateUserPayStatus`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(paymentData)
        })
        .then(response => response.json())
        .then(data => console.log("결제 상태 업데이트 성공:", data))
        .catch(error => console.error("결제 상태 업데이트 오류:", error));
    }
});