package com.albbamon.domain.payment.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Value("${api.base-url}")
    private String apiBaseUrl;

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

    @GetMapping
    public String getPaymentPage(Model model) {
    	model.addAttribute("apiBaseUrl",apiBaseUrl);
        return "payment/payment";
    }

    @GetMapping("/success")
    public String getPaymentSuccessPage(HttpSession session) {
    	session.setAttribute("item", "Y");
    	logger.info("결제 성공 후 세션에 item 값을 설정: {}", session.getAttribute("item"));
        return "payment/paymentSuccess";
    }

    @GetMapping("/fail")
    public String getPaymentFailPage() {
        return "payment/paymentFail";
    }
}
