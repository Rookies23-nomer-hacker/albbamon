package com.albbamon.domain.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JoinController {

	@GetMapping("/user/join")
	public String test() {
		return "/user/join";
	}

}