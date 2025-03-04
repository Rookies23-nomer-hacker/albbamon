package com.albbamon.domain.main.controller;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.post.entity.Post;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
	
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public MainController(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }
    
    @GetMapping("/")
    public String getAllPosts(Model model, ObjectMapper objectMapper, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String ceoNum = null;
        if (session != null) {
            ceoNum = (String) session.getAttribute("ceoNum");
        }

        List<Map<String, String>> posts = new ArrayList<>();
        List<Map<String, String>> recruitments = new ArrayList<>();
        
        try {
        	ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/list?size=12", String.class);
            JsonNode rootNode = objectMapper.readTree(responseEntity.getBody());
            JsonNode recruitmentList = rootNode.path("data").path("recruitmentList");

            for(JsonNode recruitment: recruitmentList) {
                Integer id = recruitment.path("id").asInt();
                String title = recruitment.path("title").asText();
                LocalDateTime dueDate = LocalDateTime.parse(recruitment.path("dueDate").asText());
                LocalDateTime createDate = LocalDateTime.parse(recruitment.path("createDate").asText());
                String contents = recruitment.path("content").asText();
                Integer wage = recruitment.path("wage").asInt();
                String userName = recruitment.path("userName").asText();

                Map<String, String> r = new HashMap<>();
                NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

                String formattedWage = numberFormat.format(wage);
                r.put("id", String.valueOf(id));
                r.put("title", title);
                r.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                r.put("contents", contents);
                r.put("wage", formattedWage);
                r.put("userName", userName);
                r.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                recruitments.add(r);
            }

            ResponseEntity<String> postResponseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/post/list", String.class);
            JsonNode postList = objectMapper.readTree(postResponseEntity.getBody()).path("data").path("postList");

            for (JsonNode postNode : postList) {
                int id = postNode.path("postId").asInt();
                String idStr = String.valueOf(id);
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
                LocalDateTime createDate = LocalDateTime.parse(postNode.path("createDate").asText());
                String userName = postNode.path("userName").asText();

                Map<String, String> post = new HashMap<>();
                post.put("id", idStr);
                post.put("title", title);
                post.put("contents", contents);
                post.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                post.put("userName", userName);
                posts.add(post);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        model.addAttribute("posts", posts);
        model.addAttribute("recruitmentList", recruitments); 
        model.addAttribute("ceoNum", ceoNum);
        return "main/main";
    }
    
    
}