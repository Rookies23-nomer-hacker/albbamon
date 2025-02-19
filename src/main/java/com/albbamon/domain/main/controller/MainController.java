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
import com.albbamon.domain.main.entity.MainEntity;

@Controller
public class MainController {
	
    private final RestTemplate restTemplate;
    private final ApiProperties apiProperties;

    @Value("http://localhost:8082")
    private String apiBaseUrl;

    @Autowired
    public MainController(RestTemplate restTemplate, ApiProperties apiProperties) {
        this.restTemplate = restTemplate;
        this.apiProperties = apiProperties;
    }
    
    @GetMapping("/main")
    public String getAllPosts(Model model) {
        String url = apiBaseUrl + "/api/post/";
        List<MainEntity> posts = Arrays.asList(restTemplate.getForObject(url, MainEntity[].class));
        model.addAttribute("posts", posts);
        return "main";
    }
}