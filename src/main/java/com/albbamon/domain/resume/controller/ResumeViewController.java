package com.albbamon.domain.resume.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import com.albbamon.domain.resume.dto.ResumeListDto;
import com.albbamon.domain.resume.entity.ResumeWrite;
import com.albbamon.domain.resume.entity.ResumeWriteProfile;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class ResumeViewController {
	@Value("${api.base-url}")
	private String apiBaseUrl;

	private final RestTemplate restTemplate;

	String jsondata;
	
    public ResumeViewController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

	@GetMapping("/resume/view")
	public String view(@RequestParam("resumeId") Long resumeId, Model model,HttpServletRequest request) {
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
					jsondata = objectMapper.writeValueAsString(data);
				}
			}
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
					
		HttpEntity<String> requestEntity = new HttpEntity<>(jsondata, headers);
		ResponseEntity<ResumeWrite> response = restTemplate.exchange(apiBaseUrl+"/api/resume/view?resume_id="+resumeId, HttpMethod.GET,requestEntity, ResumeWrite.class);
		ResponseEntity<ResumeWriteProfile> response2 = restTemplate.exchange(apiBaseUrl+"/api/resume/profile", HttpMethod.POST,requestEntity, ResumeWriteProfile.class);
		
		ResumeWrite profileData = response.getBody();
		String imgurl = profileData.getResume_imgurl()+profileData.getResume_img_name();
		ResumeWriteProfile userData = response2.getBody();
		String name_org = profileData.getPortfolioname();
		String name="";
		
		if(name_org!=null) {
			int dotIndex = name_org.lastIndexOf(".");
			if (dotIndex != -1) {
		        // 확장자를 제외한 파일명 부분 추출
		        String nameWithoutExt = name_org.substring(0, dotIndex);
		        String extension = name_org.substring(dotIndex); // 확장자 포함

		        // 정규식을 사용하여 "_YYYYMMDD_HHmmss" 형식의 패턴을 제거
		        nameWithoutExt = nameWithoutExt.replaceAll("_\\d{14}$", "");

		        // 최종 파일명 조합
		        name = nameWithoutExt + extension;
		    } else {
		        // 확장자가 없는 경우 정규식 적용
		    	name = name_org.replaceAll("_\\d{14}$", "");
		    }
		}
		
		if(profileData!=null) {
			model.addAttribute("resume", profileData);
			model.addAttribute("file",name);
			model.addAttribute("img",imgurl);
			model.addAttribute("user", userData);
			model.addAttribute("api_url",apiBaseUrl);
			return "resume/resume_view";
		}else {
			return "resume/resume_view";
		}
	    
	    
	}

	@GetMapping("/resume/all")
	public String getAllResumes(Model model) {
        ResponseEntity<List<ResumeListDto>> response = restTemplate.exchange(
        		apiBaseUrl+"/api/resume/all",
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<ResumeListDto>>() {}
        );
        
        model.addAttribute("resumes", response.getBody());
	    return "/resume/resume_list";
	}
}



