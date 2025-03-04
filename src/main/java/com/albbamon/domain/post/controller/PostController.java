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

    // 📌 글쓰기 페이지 이동//
    @GetMapping("/api/post/write")
    public String writePage(HttpSession session, Model model) {
        Object userIdObj = session.getAttribute("userid");
        if (userIdObj == null) {
            return "redirect:/api/user/sign-in";
        }
        model.addAttribute("apiBaseUrl", apiBaseUrl);
        return "post/post_write";
    }


    // 📌 글쓰기 처리 (파일 제외)
    @PostMapping("/api/post")
    public String createPost(@ModelAttribute CreatePostRequestDto createPostRequestDto,
                             HttpSession session, Model model) {
        Object userIdObj = session.getAttribute("userid");
        if (userIdObj == null) {
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
            return "redirect:/api/user/sign-in";
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=" + session.getId());  // ✅ 쿠키 명확하게 추가

        try {
            createPostRequestDto.setUserid(userId);
            String body = objectMapper.writeValueAsString(createPostRequestDto);

            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(apiBaseUrl + "/api/post/write", requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.CREATED || response.getStatusCode() == HttpStatus.OK) {
                return "redirect:/api/post";
            } else {
                model.addAttribute("error", "게시글 등록 실패: " + response.getStatusCode());
                model.addAttribute("apiBaseUrl", apiBaseUrl);
                return "post/post_write";
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            model.addAttribute("error", "게시글 등록 중 오류가 발생했습니다.");
            model.addAttribute("apiBaseUrl", apiBaseUrl);
            return "post/post_write";
        }
    }
}
