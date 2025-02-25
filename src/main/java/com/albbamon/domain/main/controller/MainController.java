package com.albbamon.domain.main.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.config.ApiProperties;
import com.albbamon.domain.main.entity.Main;
import com.albbamon.domain.post.entity.Post;
import com.albbamon.domain.recruitment.dto.response.GetRecruitmentResponseDto;
import com.albbamon.domain.recruitment.entity.Recruitment;
import com.albbamon.domain.user.entity.User;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {
	
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    
    //@Value("http://localhost:60085")
    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public MainController(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }
    
    @GetMapping("/")
    public String getAllPosts(Model model, ObjectMapper objectMapper) {
        String url = apiBaseUrl + "/api/post/list";
        List<Post> posts = Arrays.asList(restTemplate.getForObject(url, Post[].class));
        List<Map<String, String>> recruitments = new ArrayList<>();
        
        try {
        	ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/list", String.class);
        	
            JsonNode rootNode = objectMapper.readTree(responseEntity.getBody());
            JsonNode recruitmentList = rootNode.path("data").path("recruitmentList");

            for(JsonNode recruitment: recruitmentList) {
                Integer id = recruitment.path("id").asInt();
                String title = recruitment.path("title").asText();
                LocalDateTime dueDate = LocalDateTime.parse(recruitment.path("dueDate").asText());
                String contents = recruitment.path("content").asText();
                Integer wage = recruitment.path("wage").asInt();
                String userName = recruitment.path("userName").asText();

                Map<String, String> r = new HashMap<>();
                r.put("id", String.valueOf(id));
                r.put("title", title);
                r.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                r.put("contents", contents);
                r.put("wage", String.valueOf(wage));
                r.put("userName", userName);
                recruitments.add(r);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("recruitmentList", recruitments); 
        return "main/main";
    }
    
    
}