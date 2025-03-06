package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.albbamon.domain.user.dto.request.CreateUserRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class RegisterCeoController {
	@Value("${api.base-url}")
    private String apiBaseUrl;
	
	@GetMapping("/user/ceo")
	public String ceoRegister() {
		return "/user/registerCeo";
	}

private final RestTemplate restTemplate = new RestTemplate();
	
	@PostMapping("/user/ceo")
	public String registerUser(@ModelAttribute CreateUserRequestDto createUserRequestDto) throws JsonProcessingException {
		ObjectMapper om = new ObjectMapper();
		RestTemplate rt = new RestTemplate();
		//API 요청 URL
		String apiUrl = apiBaseUrl+ "/api/user";
		
		//HTTP 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String body = om.writeValueAsString(createUserRequestDto); // 도시락
		HttpEntity<String> requestEntity2 = new HttpEntity(body, headers); //총알
		ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity2, String.class);
		
		// 응답 상태 확인 후 로그인 페이지로 리다이렉트
        if (response.getStatusCode() == HttpStatus.OK) {
            return "redirect:/user/sign-in";
        } else {
            return "redirect:/register?error";
        }
	}
}
