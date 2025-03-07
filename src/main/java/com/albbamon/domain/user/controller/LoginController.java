package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import com.albbamon.domain.user.dto.request.LoginRequestDto;
import com.albbamon.domain.user.dto.response.LoginResponseDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@Controller
public class LoginController {
    @Value("${api.base-url}")
    private String apiBaseUrl;
    
    @GetMapping("/user/sign-in")
    public String loginPage() {
        return "user/login";
    }

    private final RestTemplate restTemplate = new RestTemplate();
    
    @PostMapping("/user/sign-in")
    public String loginUser(@ModelAttribute LoginRequestDto loginDto, Model model,HttpServletRequest request) throws JsonProcessingException {
        ObjectMapper om = new ObjectMapper();
        String apiUrl = apiBaseUrl+ "/api/user/sign-in";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        String body = om.writeValueAsString(loginDto);

        HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class);

        
        if (response.getBody() == null) {
        	model.addAttribute("error", "5회 실패로 계정이 잠겼습니다.");
            return "/user/login";
        }
        HttpSession session = request.getSession(false); // 기존 세션 유지
        if (session == null) {
            session = request.getSession(); // 새 세션 생성 (필요할 때만)
        }

        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            LoginResponseDto userDto = om.readValue(response.getBody(), LoginResponseDto.class);
            if (userDto.getPwChkNum()>0) {
            	session.invalidate();
            	model.addAttribute("error", "비밀번호를 "+userDto.getPwChkNum()+"회 실패했습니다.");
                return "/user/login"; // 로그인 페이지로 다시 이동
            }
            session.setAttribute("userid", String.valueOf(userDto.getUserId()));
            session.setAttribute("email", userDto.getEmail());
            session.setAttribute("ceoNum", userDto.getCeoNum());
            session.setAttribute("item", userDto.getItem());
            return "redirect:/"; // 메인으로 redirect
        }
        return "redirect:/";
    }
    @GetMapping("/user/log-out")
    public String logout(HttpServletRequest request,HttpServletResponse response) {
    	
    	HttpSession session = request.getSession(false);
    	if(session!=null) {
    		session.invalidate();
    	}
    	
    	return "redirect:/";
    }


    @PostMapping("/user/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 삭제
        return "redirect:/user/login";
    }
}
