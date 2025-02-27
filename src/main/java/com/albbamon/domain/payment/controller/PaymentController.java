package com.albbamon.domain.payment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
    // 결제 페이지로 이동하는 메서드
    @GetMapping("/payment")
    public String getPaymentPage(Model model) {
        return "payment/payment";  // JSP 파일을 반환합니다. paymentPage.jsp
    }

    // 결제 완료 후 결제 결과 보여주는 페이지로 이동
    @GetMapping("/success")
    public String getPaymentSuccessPage(HttpSession session) {
    	session.setAttribute("item", "Y");
    	logger.info("결제 성공 후 세션에 item 값을 설정: {}", session.getAttribute("item"));
        return "payment/paymentSuccess";
    }
    
    // 결제 실패
    @GetMapping("/fail")
    public String getPaymentFailPage() {
        return "payment/paymentFail";
    }
}
