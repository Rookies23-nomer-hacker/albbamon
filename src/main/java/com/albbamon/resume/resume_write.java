package com.albbamon.resume;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import com.albbamon.resume.dto.Resume_write_DTO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class resume_write {
	
	String jsondata;

	@GetMapping("/api/resume/write")
	public String wrtie() {
		
		return "resume/resume_write";
	}
	
	@PostMapping("/api/resume/write")
	public String wwww(@ModelAttribute Resume_write_DTO resume_write_DTO) {
		
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> data = new HashMap<>();
		
		
		try {
			data.put("education", resume_write_DTO.getEducation());
			data.put("status", resume_write_DTO.getStatus());
			data.put("personal", resume_write_DTO.getPersonal());
			data.put("work_place_region", resume_write_DTO.getWork_place_region());
			data.put("work_place_city", resume_write_DTO.getWork_place_city());
			data.put("industry_occupation", resume_write_DTO.getIndustry_occupation());
			data.put("employmentType", resume_write_DTO.getEmploymentType());
			data.put("working_period", resume_write_DTO.getWorking_period());
			data.put("working_day", resume_write_DTO.getWorking_day());
			data.put("statement", resume_write_DTO.getStatement());
			data.put("portfolioData", resume_write_DTO.getPortfolioData());
			data.put("portfolioName", resume_write_DTO.getPortfolioName());
			jsondata = objectMapper.writeValueAsString(data);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("이력서 : "+ jsondata);
		return "resume/resume_write";
	}

}