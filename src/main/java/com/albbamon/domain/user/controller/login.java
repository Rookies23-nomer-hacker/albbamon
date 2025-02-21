package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.albbamon.domain.user.dto.request.LoginRequestDto;
import com.albbamon.domain.user.entity.User;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

//import javax.servlet.http.HttpSession;

@Controller
public class login {
	 //@Value("http://localhost:60085")
    @Value("${api.base-url}")
    private String apiBaseUrl;
    
    @GetMapping("/api/user/sign-in")
    public String loginPage() {
        return "user/login"; // login.jsp로 이동
    }

    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/api/user/sign-in")
    public String loginUser(@ModelAttribute LoginRequestDto loginDto, Model model,HttpServletRequest request) throws JsonProcessingException {
        ObjectMapper om = new ObjectMapper();
        String apiUrl = apiBaseUrl+ "/api/user/sign-in";
        
        System.out.println("비밀번호 " + loginDto.getPassword());
        System.out.println("이거ㅓㅓㅓㅓㅓㅓㅓㅓㅓ " + loginDto.toString());

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String body = om.writeValueAsString(loginDto);

        // ✅ 요청 데이터 로그 출력 (디버깅용)
        System.out.println("로그인 요청 데이터: " + body);

        HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class);

        // ✅ 응답 로그 출력 (디버깅용)
        System.out.println("API 응답: " + response);

        HttpSession session = request.getSession(false); // 기존 세션 유지
        if (session == null) {
            session = request.getSession(); // 새 세션 생성 (필요할 때만)
        }
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            session.setAttribute("userid", response.getBody());
            System.out.println(session.getAttribute("userid"));
            return "/main/main"; // main.jsp로 이동
        } else {
            model.addAttribute("error", "이메일 또는 비밀번호가 잘못되었습니다.");
            return "api/user/sign-in"; // 로그인 페이지로 다시 이동
        }
    }


    @PostMapping("/user/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 삭제
        return "redirect:/user/login";
    }
}
