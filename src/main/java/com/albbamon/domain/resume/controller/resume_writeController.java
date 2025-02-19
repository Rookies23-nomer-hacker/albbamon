package com.albbamon.domain.resume.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.resume.dto.Resume_write_DTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class resume_writeController {
	
	String jsondata;
	private final String TARGET_API_URL ="http://192.168.0.251:8083/api/resume/write";

	@GetMapping("/api/resume/write")
	public String wrtie() {
		
		return "resume/resume_write";
	}
	
	@PostMapping("/api/resume/write")
	public String wwww(@ModelAttribute Resume_write_DTO resume_write_DTO) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> data = new HashMap<>();
		String school = resume_write_DTO.getSchool();
		String status = resume_write_DTO.getStatus();
		String personal = resume_write_DTO.getPersonal();
		String work_place_region = resume_write_DTO.getWork_place_region();
		String work_place_city = resume_write_DTO.getWork_place_city();
		String industry_occupation = resume_write_DTO.getIndustry_occupation();
		String employmentType = resume_write_DTO.getEmploymentType();
		String working_period = resume_write_DTO.getWorking_period();
		String working_day = resume_write_DTO.getWorking_day();
		String introduction = resume_write_DTO.getIntroduction();
		String portfolioData = resume_write_DTO.getPortfolioData();
		String portfolioName = resume_write_DTO.getPortfolioName();
		//
		try {
			data.put("school", school);
			data.put("status", status);
			data.put("personal", personal);
			data.put("work_place_region", work_place_region);
			data.put("work_place_city", work_place_city);
			data.put("industry_occupation", industry_occupation);
			data.put("employmentType", employmentType);
			data.put("working_period", working_period);
			data.put("working_day", working_day);
			data.put("introduction", introduction);
			data.put("portfolioData", portfolioData);
			data.put("portfolioName", portfolioName);
			jsondata = objectMapper.writeValueAsString(data);
			
			// API 서버로 JSON 데이터 전송
			RestTemplate restTemplate = new RestTemplate();
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
						
			HttpEntity<String> requestEntity = new HttpEntity<>(jsondata, headers);
			ResponseEntity<String> response = restTemplate.exchange(TARGET_API_URL, HttpMethod.POST, requestEntity, String.class);

			// 응답 확인
			System.out.println("API 서버 응답: " + response.getBody());
			
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("이력서 : "+ jsondata);
		return "resume/resume_write";
	}

}