package com.albbamon.domain.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.post.dto.request.CreatePostRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class PostController {

    private String body;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    private final RestTemplate restTemplate;

    @Autowired
    public PostController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 📌 글쓰기 페이지 이동
    @GetMapping("/api/post/write")
    public String write() {
        return "post/post_write";  // post_write.jsp
    }

    // 📌 글쓰기 처리
    @PostMapping("/api/post")
    public String createPost(@ModelAttribute CreatePostRequestDto createPostRequestDto) {
        ObjectMapper objectMapper = new ObjectMapper();
        HttpHeaders headers = new HttpHeaders();

        // 📌 Content-Type 설정
        headers.setContentType(MediaType.APPLICATION_JSON);

        // 📌 (선택) 세션 쿠키 추가
        headers.add("Cookie", "JSESSIONID=9DE11CA851C45A26599CC27EB8F386F2");

        try {
            // 📌 DTO를 JSON 문자열로 변환
            body = objectMapper.writeValueAsString(createPostRequestDto);
            System.out.println("전송 데이터 (body): " + body);

            // 📌 HTTP 요청 생성
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);

            // 📌 API 호출 (Post 요청)
            ResponseEntity<String> response = restTemplate.postForEntity(apiBaseUrl + "/api/post", requestEntity, String.class);
            System.out.println("API 응답: " + response.getBody());

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // 📌 글 작성 후 게시글 목록으로 이동
        return "redirect:/api/post";
    }

 

}
