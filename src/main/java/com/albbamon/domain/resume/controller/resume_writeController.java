package com.albbamon.domain.resume.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.resume.entity.Resume_write;
import com.albbamon.domain.resume.entity.Resume_write_profile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;


@Controller
public class resume_writeController {
	
	String jsondata;
	String jsondata2;
	private final String TARGET_API_URL ="http://192.168.0.251:8083/api/resume/write";
	

	
	private final RestTemplate restTemplate;
	

    String url = "http://192.168.0.251:8083/api/resume/profile";
    public resume_writeController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
	@GetMapping("/api/resume/write")
	public String wrtie(Model model) {
		//
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> data = new HashMap<>();
		ObjectMapper objectMapper = new ObjectMapper();
		
		try {
			data.put("email", "testt@gmail.com");
			jsondata2 = objectMapper.writeValueAsString(data);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
					
		HttpEntity<String> requestEntity = new HttpEntity<>(jsondata2, headers);
		ResponseEntity<Resume_write_profile> response = restTemplate.exchange(url, HttpMethod.POST,requestEntity, Resume_write_profile.class);
		System.out.println(response.getBody().getEmail());
		System.out.println(response.getBody().getName());
		System.out.println(response.getBody().getPhone());
		Resume_write_profile profileData = response.getBody();
		model.addAttribute("profile", profileData);
		return "resume/resume_write";
	}
	
	@PostMapping("/api/resume/write")
	public String wwww(@ModelAttribute Resume_write resume_write) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule()); // JavaTimeModule 등록
	    objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // ISO-8601 포맷 사용
	    
		Map<String, Object> data = new HashMap<>();
		String school = resume_write.getSchool();
		String status = resume_write.getStatus();
		String personal = resume_write.getPersonal();
		String work_place_region = resume_write.getWork_place_region();
		String work_place_city = resume_write.getWork_place_city();
		String industry_occupation = resume_write.getIndustry_occupation();
		String employmentType = resume_write.getEmploymentType();
		String working_period = resume_write.getWorking_period();
		String working_day = resume_write.getWorking_day();
		String introduction = resume_write.getIntroduction();
		String portfolioName = resume_write.getPortfolioName();
		LocalDateTime create_date = LocalDateTime.now();
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
			data.put("portfolioName", portfolioName);
			data.put("create_date", create_date);
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
		//System.out.println("이력서 : "+ jsondata);
		return "resume/resume_write";
	}

}