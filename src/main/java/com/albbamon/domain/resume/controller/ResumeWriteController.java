package com.albbamon.domain.resume.controller;

import java.util.HashMap;
import java.util.Map;
import java.time.LocalDateTime;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.albbamon.domain.resume.entity.FileData;
import com.albbamon.domain.resume.entity.ResumeWrite;
import com.albbamon.domain.resume.entity.ResumeWriteProfile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.SerializationFeature;


@Controller
public class ResumeWriteController {
	@Value("${api.base-url}")
	private String apiBaseUrl;

	private final RestTemplate restTemplate;
	String jsondata;
	String jsondata2;
	
    public ResumeWriteController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    @GetMapping("/resume")
    public String resume(Model model,HttpServletRequest request){
    	HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> data = new HashMap<>();
		ObjectMapper objectMapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if (session != null) {
				String session_user=(String) session.getAttribute("userid");
				if(session_user==null) {
					model.addAttribute("NotLogin", 1);
					return "user/login";
				}else {
					Long userId = Long.parseLong(session_user);
					data.put("user_id", userId);
					jsondata2 = objectMapper.writeValueAsString(data);
				}
			}
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
					
		HttpEntity<String> requestEntity = new HttpEntity<>(jsondata2, headers);
		ResponseEntity<ResumeWrite> response = restTemplate.exchange(apiBaseUrl+"/api/resume", HttpMethod.POST,requestEntity, ResumeWrite.class);
		ResumeWrite profileData = response.getBody();
		if(profileData!=null) {
			model.addAttribute("resume", profileData);
			return "resume/resume";
		}else {
			return "resume/resume";
		}
    }
    
    
    @GetMapping("/resume/delete")
    public String delete(Model model,HttpServletRequest request,RedirectAttributes redirectAttributes){
    	HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> data = new HashMap<>();
		ObjectMapper objectMapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if (session != null) {
				String session_user=(String) session.getAttribute("userid");
				if(session_user==null) {
					model.addAttribute("NotLogin", 1);
					return "user/login";
				}else {
					Long userId = Long.parseLong(session_user);
					data.put("user_id", userId);
					jsondata2 = objectMapper.writeValueAsString(data);
				}
			}
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
					
		HttpEntity<String> requestEntity = new HttpEntity<>(jsondata2, headers);
		ResponseEntity<ResumeWrite> resume_response = restTemplate.exchange(apiBaseUrl+"/api/resume", HttpMethod.POST,requestEntity, ResumeWrite.class);
		ResumeWrite profileData = resume_response.getBody();
		
		Long resume_id = profileData.getResume_id();

		HttpEntity<Long> requestEntity2 = new HttpEntity<>(resume_id, headers);
		ResponseEntity<String> response = restTemplate.exchange(apiBaseUrl+"/api/resume/delete?resume_id="+resume_id, HttpMethod.GET,requestEntity2, String.class);
		
		redirectAttributes.addFlashAttribute("delete", response.getBody());
		return "redirect:/resume";
    }
    
	@GetMapping("/resume/write")
	public String writeResume(Model model,HttpServletRequest request) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		Map<String, Object> data = new HashMap<>();
		ObjectMapper objectMapper = new ObjectMapper();
		HttpSession session = request.getSession(false);
		try {
			if (session != null) {
				String session_user=(String) session.getAttribute("userid");
				if(session_user==null) {
					return "user/login";
				}else {
					Long userId = Long.parseLong(session_user);
					data.put("user_id", userId);
					jsondata2 = objectMapper.writeValueAsString(data);
				}
			}
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
					
		HttpEntity<String> requestEntity = new HttpEntity<>(jsondata2, headers);
		ResponseEntity<ResumeWriteProfile> response = restTemplate.exchange(apiBaseUrl+"/api/resume/profile", HttpMethod.POST,requestEntity, ResumeWriteProfile.class);
		ResumeWriteProfile profileData = response.getBody();
		model.addAttribute("profile", profileData);
		return "resume/resume_write";
	}
	
	@PostMapping("/resume/write")
	public String wwww(@ModelAttribute ResumeWrite resume_write, FileData file_data, HttpServletRequest request, RedirectAttributes redirectAttributes) {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule()); // JavaTimeModule 등록
		objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS); // ISO-8601 포맷 사용

		Map<String, Object> data = new HashMap<>();
		HttpSession session = request.getSession(false);
		
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
		LocalDateTime create_date = LocalDateTime.now();
		String portfoliodata = file_data.getPortfolioData();
		String portfolioname = resume_write.getPortfolioname();
		String resume_img_data = file_data.getResume_img_data();
		String resume_img_name = resume_write.getResume_img_name();

		try {
			if (session != null) {
				String session_user=(String) session.getAttribute("userid");
				Long userId = Long.parseLong(session_user);
				jsondata2 = objectMapper.writeValueAsString(data);
				data.put("user_id", userId);
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
				data.put("create_date", create_date);
				data.put("portfolioData", portfoliodata);
				data.put("portfolioName",portfolioname);
				data.put("resume_img_data",resume_img_data);
				data.put("resume_img_name", resume_img_name);
				jsondata = objectMapper.writeValueAsString(data);
				// API 서버로 JSON 데이터 전송
				RestTemplate restTemplate = new RestTemplate();
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_JSON);
							
				HttpEntity<String> requestEntity = new HttpEntity<>(jsondata, headers);
				ResponseEntity<String> response = restTemplate.exchange(apiBaseUrl+"/api/resume/write", HttpMethod.POST, requestEntity, String.class);

				if(response.getBody().equals("이미 이력서가 있습니다.")) {
					redirectAttributes.addFlashAttribute("duplicated", "이미 이력서가 있습니다.");
					return "redirect:/resume";
				}else {
					redirectAttributes.addFlashAttribute("duplicated", response.getBody());
					return "redirect:/resume";
				}
			}
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return "resume/resume_write";
	}

}