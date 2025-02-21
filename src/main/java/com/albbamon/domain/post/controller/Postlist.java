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

@Controller
public class Postlist {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public Postlist(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/api/post")
    public String getAllPosts(Model model) {
        String url = apiBaseUrl + "/api/post/list";
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);

        // 전체 JSON 응답 출력
        System.out.println("+++++++++++++++++++++== " + response.getBody());

        List<Map<String, String>> posts = new ArrayList<>();

        try {
            // JSON 파싱
            ObjectMapper mapper = new ObjectMapper();
            JsonNode postList = mapper.readTree(response.getBody());

            // postList 순회
            for (JsonNode postNode : postList) {
            	int id = postNode.path("postId").asInt();  // asInt() 사용
                String idStr = String.valueOf(id);     // 문자열로 변환
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
//                String file = postNode.path("file").asText();
                String createDate = postNode.path("createDate").asText();
                String userName = postNode.path("userName").asText();

                // 각 필드 콘솔 출력
                System.out.println("===== Post Item =====");
                System.out.println("Id:" + idStr);
                System.out.println("Title: " + title);
                System.out.println("Contents: " + contents);
//                System.out.println("File: " + file);
                System.out.println("userName: " + userName);
                System.out.println("createDate: " + createDate);
                System.out.println("=====================");

                // Map에 저장
                Map<String, String> post = new HashMap<>();
                post.put("id", idStr);  // 문자열 형태로 저장
                post.put("title", title);
                post.put("contents", contents);
//                post.put("file", file);
                post.put("userName", userName);
                post.put("createDate", createDate);
                posts.add(post);
                
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 모델에 데이터 추가
        model.addAttribute("posts", posts);

        // post_list.jsp로 이동
        return "post/post_list";
        
        
    }
    
    
}
