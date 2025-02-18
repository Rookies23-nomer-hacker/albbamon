package com.albbamon.career;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class zlzl {

	@GetMapping("/zlzl")
	public String testd() {
		return "sss";
	}

}