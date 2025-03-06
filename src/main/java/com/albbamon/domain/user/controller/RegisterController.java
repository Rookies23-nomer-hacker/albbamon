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
public class RegisterController {
    @Value("${api.base-url}")
    private String apiBaseUrl;
    
	@GetMapping("/user")
	public String register() {
		return "/user/register";
	}

private final RestTemplate restTemplate = new RestTemplate();
	
	@PostMapping("/user")
	public String createUser(@ModelAttribute CreateUserRequestDto registerDto) throws JsonProcessingException {
		ObjectMapper om = new ObjectMapper();
		//API 요청 URL
		String apiUrl = apiBaseUrl+ "/api/user";
		
		//HTTP 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		String body = om.writeValueAsString(registerDto); // 도시락
		HttpEntity<String> requestEntity2 = new HttpEntity(body, headers); //총알
		ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity2, String.class);
		

        if (response.getStatusCode() == HttpStatus.OK) {
            return "redirect:/user/sign-in";
        } else {
            return "redirect:/register?error";
        }
	}
}
