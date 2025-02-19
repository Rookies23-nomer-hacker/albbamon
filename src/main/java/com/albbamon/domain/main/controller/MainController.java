package com.albbamon.domain.main.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

public class MainController {
/*
    private final RestTemplate restTemplate;

    @Value("${api.base.url}") // API 서버의 기본 URL (예: http://api-server-ip:8080)
    private String apiBaseUrl;

    public WebController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/posts")
    public String getAllPosts(Model model) {
        String url = apiBaseUrl + "/api/post/";
        List<MainEntity> posts = Arrays.asList(restTemplate.getForObject(url, MainEntity[].class)); // API에서 데이터 가져오기
        model.addAttribute("posts", posts); // JSP에 데이터 전달
        return "index"; // JSP 파일 이름 (index.jsp)
    }
    */
}