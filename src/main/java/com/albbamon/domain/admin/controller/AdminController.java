package com.albbamon.domain.admin.controller;

import com.albbamon.domain.admin.dto.request.AdminSigeInRequestDto; // 아이디·비밀번호 담는 DTO
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RequiredArgsConstructor
@Controller
public class AdminController {

    @Value("${api.base-url}")
    private String apiBaseUrl;

    private final ObjectMapper objectMapper = new ObjectMapper();

    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/sign-in")
    public String showSignInForm() {
        return "notice/adminLogin"; // JSP 경로
    }

    @PostMapping("/sign-in")
    public String processSignIn(AdminSigeInRequestDto requestDto,
                                HttpSession session,
                                Model model) {

        // API 서버 URL (관리자 로그인)
        String apiUrl = apiBaseUrl + "/api/07060310/albba/admin/sign-in";

        try {
            // 1. 요청 바디(JSON) 준비
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String requestBody = objectMapper.writeValueAsString(requestDto); // DTO → JSON
            HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

            // 2. RestTemplate으로 POST 요청
            ResponseEntity<String> response = restTemplate.exchange(
                    apiUrl,
                    HttpMethod.POST,
                    requestEntity,
                    String.class
            );

            // 3. 응답 코드 확인
            if (response.getStatusCode() == HttpStatus.OK) {
                // 3-1. 응답 JSON 파싱
                Map<String, Object> responseMap = objectMapper.readValue(
                        response.getBody(),
                        new TypeReference<Map<String, Object>>() {}
                );
                if(!"admin".equals(responseMap.get("identity"))) {
                	model.addAttribute("errorMessage", "로그인 실패: 잘못된 아이디 또는 비밀번호입니다.");
                    return "notice/adminLogin";
                }
                session.setAttribute("adminId", responseMap.get("identity"));
                System.out.println(session.getAttribute("adminId"));
                return "redirect:/";
            } else {
                model.addAttribute("errorMessage", "로그인 실패: 잘못된 아이디 또는 비밀번호입니다.");
                return "notice/adminLogin";
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "로그인 중 오류가 발생했습니다.");
            return "notice/adminLogin";
        }
    }
}
