package com.albbamon.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class join {

	@GetMapping("/api/user/join")
	public String test() {
		return "/user/join";
	}

}