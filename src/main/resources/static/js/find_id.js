document.addEventListener("DOMContentLoaded", function () {
    showWho('P'); // 기본적으로 '개인회원'을 표시
});

function showWho(who) {
    const tabButtons = document.querySelectorAll(".tab-menu button");
    const PERSONAL = document.getElementById("PERSONAL");
    const CORPORATION = document.getElementById("CORPORATION");

    // 모든 버튼에서 'active' 클래스 제거
    tabButtons.forEach(button => button.classList.remove("active"));

    // 모든 콘텐츠 숨김
    PERSONAL.style.display = "none";
    CORPORATION.style.display = "none";

    // 선택한 탭에 'active' 클래스 추가하고, 해당 콘텐츠 보이기
    if (who === "P") {
        tabButtons[0].classList.add("active");
        PERSONAL.style.display = "block";
    } else if (who === "C") {
        tabButtons[1].classList.add("active");
        CORPORATION.style.display = "block";
    }
}

// 탭 클릭 이벤트 리스너 추가
document.querySelector(".tab-menu button:first-child").addEventListener("click", function () {
    showWho('P');
});
document.querySelector(".tab-menu button:last-child").addEventListener("click", function () {
    showWho('C');
});
document.addEventListener("DOMContentLoaded", function() {
    showWho('P'); // 기본적으로 '개인회원'을 표시

    const radioButtonsPersonal = document.querySelectorAll("#PERSONAL input[name='find-method']");
    const radioButtonsCorporation = document.querySelectorAll("#CORPORATION input[name='find-method']");

    const personalForms = {
        "contact": document.querySelector("#PERSONAL #contact-form"),
        "email": document.querySelector("#PERSONAL #email-form"),
        "auth": document.querySelector("#PERSONAL #auth-form"),
        "ipin": document.querySelector("#PERSONAL #ipin-form")
    };

    const corporationForms = {
        "contact": document.querySelector("#CORPORATION #contact-form"),
        "email": document.querySelector("#CORPORATION #email-form"),
        "auth": document.querySelector("#CORPORATION #auth-form"),
        "ipin": document.querySelector("#CORPORATION #ipin-form")
    };

    function updateFormVisibility(forms, selectedValue) {
        for (let key in forms) {
            forms[key].style.display = key === selectedValue ? "block" : "none";
        }
    }

    function addRadioEventListeners(radioButtons, forms) {
        radioButtons.forEach(radio => {
            radio.addEventListener("change", function() {
                updateFormVisibility(forms, document.querySelector(`#${forms === personalForms ? "PERSONAL" : "CORPORATION"} input[name='find-method']:checked`).value);
            });
        });
    }

    // 개인회원 및 기업회원의 라디오 버튼 이벤트 리스너 등록
    addRadioEventListeners(radioButtonsPersonal, personalForms);
    addRadioEventListeners(radioButtonsCorporation, corporationForms);

    // 초기 상태 업데이트
    updateFormVisibility(personalForms, document.querySelector("#PERSONAL input[name='find-method']:checked").value);
    updateFormVisibility(corporationForms, document.querySelector("#CORPORATION input[name='find-method']:checked").value);
});
