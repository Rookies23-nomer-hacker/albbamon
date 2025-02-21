package com.albbamon.domain.resume.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class resume_statusController {

	@GetMapping("/api/resume/status")
	public String test() {
		return "/resume/resume_status";
	}

}