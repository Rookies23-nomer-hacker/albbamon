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
        System.out.println("📌 글쓰기 페이지 이동 - 현재 세션 ID: " + session.getId());  // ✅ 세션 ID 확인

        Object userIdObj = session.getAttribute("userid");
        if (userIdObj == null) {
            System.out.println("❌ 세션의 userid 없음 → 로그인 페이지로 이동");
            return "redirect:/api/user/sign-in";
        }

        System.out.println("✅ 로그인된 사용자 ID: " + userIdObj);
        return "post/post_write";
    }


    // 📌 글쓰기 처리 (파일 제외)
    @PostMapping("/api/post")
    public String createPost(@ModelAttribute CreatePostRequestDto createPostRequestDto,
                             HttpSession session, Model model) {

        // ✅ 세션에서 userId 가져오기
        System.out.println("📌 글 작성 요청 - 현재 세션 ID: " + session.getId());  // ✅ 세션 ID 확인
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            System.out.println("❌ 세션의 userid 없음 → 로그인 페이지로 이동");
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
            System.out.println("❌ 세션의 userid가 올바르지 않음: " + userIdObj);
            return "redirect:/api/user/sign-in";
        }

        // ✅ 세션 유지 확인
        System.out.println("✅ 로그인된 사용자 ID: " + userId);
        System.out.println("✅ API 요청 시 전달할 세션 ID: " + session.getId());

        // ✅ 헤더 설정 (쿠키 포함)
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=" + session.getId());  // ✅ 쿠키 명확하게 추가

        try {
            // 📌 CreatePostRequestDto 객체를 JSON으로 변환
            createPostRequestDto.setUserid(userId);
            String body = objectMapper.writeValueAsString(createPostRequestDto);

            // ✅ 요청 엔티티 생성
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);

            // ✅ API 서버에 POST 요청
            ResponseEntity<String> response = restTemplate.postForEntity(apiBaseUrl + "/api/post/write", requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.CREATED || response.getStatusCode() == HttpStatus.OK) {
                System.out.println("✅ 게시글이 성공적으로 등록되었습니다.");
                return "redirect:/api/post";
            } else {
                System.out.println("❌ 게시글 등록 실패: " + response.getStatusCode());
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
