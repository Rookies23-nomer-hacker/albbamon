package com.albbamon.domain.main.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.config.ApiProperties;
import com.albbamon.domain.main.entity.Main;
import com.albbamon.domain.user.entity.User;

@Controller
public class MainController {
	
    private final RestTemplate restTemplate;

    //@Value("http://localhost:60085")
    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public MainController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
    @GetMapping("/")
    public String getAllPosts(Model model) {
        String url = apiBaseUrl + "/api/post/list";
        List<Main> posts = Arrays.asList(restTemplate.getForObject(url, Main[].class));
        
        model.addAttribute("posts", posts);
        return "main/main";
    }
    
    
}