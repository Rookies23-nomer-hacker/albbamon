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

        // 전체 JSON 응답 출력 (디버깅용)
        System.out.println("+++++++++++++++++++++== " + response.getBody());

        List<Map<String, String>> posts = new ArrayList<>();

        try {
            // JSON 파싱
            ObjectMapper mapper = new ObjectMapper();
            JsonNode postList = mapper.readTree(response.getBody());

            // 게시글 리스트 순회
            for (JsonNode postNode : postList) {
                int id = postNode.path("postId").asInt();  // 게시글 ID
                String idStr = String.valueOf(id);        // 문자열로 변환
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
                String createDate = postNode.path("createDate").asText();
                String userName = postNode.path("userName").asText();

                // 각 게시글 정보 출력 (디버깅용)
                System.out.println("===== Post Item =====");
                System.out.println("Id: " + idStr);
                System.out.println("Title: " + title);
                System.out.println("Contents: " + contents);
                System.out.println("UserName: " + userName);
                System.out.println("CreateDate: " + createDate);
                System.out.println("=====================");

                // Map에 게시글 정보 저장
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

        // ✅ 세션 값 확인
        System.out.println(session.getAttribute("userid"));
        
        Object userId = session.getAttribute("userid");
        if (userId != null) {
            System.out.println("로그인된 사용자 ID: " + userId);
            model.addAttribute("isLoggedIn", true);
        } else {
            System.out.println("로그인되지 않은 사용자");
            model.addAttribute("isLoggedIn", false);
        }

        // 모델에 게시글 목록 추가
        model.addAttribute("posts", posts);

        // post_list.jsp로 이동
        return "post/post_list";
    }
}
