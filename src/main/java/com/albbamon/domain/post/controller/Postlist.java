package com.albbamon.domain.post.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Postlist {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public Postlist(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 📌 게시글 목록 불러오기 (세션 체크 포함)
    @GetMapping("/api/post")
    public String getAllPosts(Model model, HttpSession session) {
        String url = apiBaseUrl + "/api/post/list";
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        List<Map<String, String>> posts = new ArrayList<>();

        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode postList = mapper.readTree(response.getBody()).path("data").path("postList");

            for (JsonNode postNode : postList) {
                int id = postNode.path("postId").asInt();
                String idStr = String.valueOf(id);
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
                String createDate = postNode.path("createDate").asText();
                String userName = postNode.path("userName").asText();

                Map<String, String> post = new HashMap<>();
                post.put("id", idStr);
                post.put("title", title);
                post.put("contents", contents);
                post.put("userName", userName);
                post.put("createDate", createDate);

                posts.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        Object userId = session.getAttribute("userid");
        if (userId != null) {
            model.addAttribute("isLoggedIn", true);
        } else {
            model.addAttribute("isLoggedIn", false);
        }

        model.addAttribute("posts", posts);

        return "post/post_list";
    }
    
    @GetMapping("/api/post/search")
    public String searchPosts(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
        String url = apiBaseUrl + "/api/post/search?keyword=" + keyword;
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);

        List<Map<String, String>> posts = new ArrayList<>();
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode postList = mapper.readTree(response.getBody());

            for (JsonNode postNode : postList) {
                Map<String, String> post = new HashMap<>();
                post.put("id", String.valueOf(postNode.path("postId").asInt()));
                post.put("title", postNode.path("title").asText());
                post.put("contents", postNode.path("contents").asText());
                post.put("userName", postNode.path("userName").asText());
                post.put("createDate", postNode.path("createDate").asText());

                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("posts", posts);
        model.addAttribute("isLoggedIn", session.getAttribute("userid") != null);

        return "post/post_list";
    }
}