package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.user.dto.request.CreateUserRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class register {
    @Value("${api.base-url}")
    private String apiBaseUrl;
    
	@GetMapping("/api/user")
	public String reg() {
		return "/user/register";
	}

private final RestTemplate restTemplate = new RestTemplate();
	
	@PostMapping("/api/user")
	public String registerUser(@ModelAttribute CreateUserRequestDto registerDto) throws JsonProcessingException {
		ObjectMapper om = new ObjectMapper();
		RestTemplate rt = new RestTemplate();
		//API 요청 URL
		String apiUrl = apiBaseUrl+ "/api/user";
		
		//HTTP 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		
		String body = om.writeValueAsString(registerDto); // 도시락
		
		System.out.println("데이터 : " + body );
		
		
		
		//HTTP 요청 본문에 데이터 추가
		//HttpEntity<RegisterDto> requestEntity = new HttpEntity<>(registerDto, headers);
		
		//API 호출 및 응답 받기
//		ResponseEntity<String> response = restTemplate.exchange(
//                apiUrl,  // API URL
//                HttpMethod.POST,  // HTTP 메서드
//                requestEntity,  // 요청 데이터
//                String.class  // 응답 타입
//        );
		HttpEntity<String> requestEntity2 = new HttpEntity(body, headers); //총알
		ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity2, String.class);
		System.out.println("결과 : " + response);
		
		
		// 응답 상태 확인 후 로그인 페이지로 리다이렉트
        if (response.getStatusCode() == HttpStatus.OK) {
        	System.out.println("회원가입성ㄱ오");
            return "redirect:/api/user/sign-in";
        } else {
            return "redirect:/user/register?error";
        }
	}
	/*
	 * public String reg(RegisterDto resterDto) {
	 * 
	 * 
	 * System.out.println(resterDto); return "/user/login"; }
	 */

}
