package com.albbamon.resume;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import com.albbamon.resume.dto.Resume_write_DTO;


@Controller
public class resume_write {

	@GetMapping("/api/resume/write")
	public String wrtie() {
		
		return "resume/resume_write";
	}
	@PostMapping("/api/resume/write")
	public String wwww(@ModelAttribute Resume_write_DTO resume_write_DTO) {
		
		System.out.println("이력서 : "+ resume_write_DTO);
		
		return "resume/resume_write";
	}

}