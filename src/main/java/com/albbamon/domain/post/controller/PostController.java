package com.albbamon.domain.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.post.dto.request.CreatePostRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostController {

    @Value("${api.base-url}")
    private String apiBaseUrl;

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Autowired
    public PostController(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    // 📌 글쓰기 페이지 이동
    @GetMapping("/api/post/write")
    public String writePage(HttpSession session, Model model) {
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            System.out.println("세션의 userid가 없습니다.");
            return "redirect:/api/user/sign-in";
        }

        try {
            Long userId;
            if (userIdObj instanceof Long) {
                userId = (Long) userIdObj;
            } else if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);
            } else {
                throw new NumberFormatException("userid가 올바른 타입이 아님");
            }

            System.out.println("로그인된 사용자 ID: " + userId);
        } catch (NumberFormatException e) {
            System.out.println("세션의 userid가 올바르지 않습니다: " + userIdObj);
            return "redirect:/api/user/sign-in";
        }

        return "post/post_write";  // post_write.jsp로 이동
    }

    // 📌 글쓰기 처리 (파일 제외)
    @PostMapping("/api/post")
    public String createPost(@ModelAttribute CreatePostRequestDto createPostRequestDto,
                             HttpSession session, Model model) {

        // 세션에서 userId 가져오기
        Object userIdObj = session.getAttribute("userid");
        if (userIdObj == null) {
            System.out.println("세션의 userid가 없습니다.");
            return "redirect:/api/user/sign-in";
        }

        Long userId;
        try {
            if (userIdObj instanceof Long) {
                userId = (Long) userIdObj;
            } else if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);
            } else {
                throw new NumberFormatException("userid가 올바른 타입이 아님");
            }
        } catch (NumberFormatException e) {
            System.out.println("세션의 userid가 올바르지 않습니다: " + userIdObj);
            return "redirect:/api/user/sign-in";
        }

        // 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=" + session.getId());

        try {
            // 📌 CreatePostRequestDto 객체를 JSON으로 변환
            String body = objectMapper.writeValueAsString(createPostRequestDto);

            // 요청 엔티티 생성
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);

            // API 서버에 POST 요청
            ResponseEntity<String> response = restTemplate.postForEntity(apiBaseUrl + "/api/post/write", requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.CREATED || response.getStatusCode() == HttpStatus.OK) {
                System.out.println("게시글이 성공적으로 등록되었습니다.");
                return "redirect:/api/post";
            } else {
                System.out.println("게시글 등록 실패: " + response.getStatusCode());
                model.addAttribute("error", "게시글 등록 실패: " + response.getStatusCode());
                return "post/post_write";
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            model.addAttribute("error", "게시글 등록 중 오류가 발생했습니다.");
            return "post/post_write";
        }
    }
}
