package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.user.dto.request.UserInfoRequestDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserAccountController {

    @Value("${api.base-url}")
    private String apiBaseUrl;

    private final RestTemplate restTemplate = new RestTemplate(new JdkClientHttpRequestFactory());
    private final ObjectMapper objectMapper = new ObjectMapper();

    @GetMapping("/user/account")
    public String getUserAccount(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userid") == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "/user/account"; // 로그인 페이지 또는 오류 
        }

        Object userIdObj = session.getAttribute("userid");
        Long userId = null;

        if (userIdObj instanceof String) {
            userId = Long.parseLong((String) userIdObj);
        } else if (userIdObj instanceof Long) {
            userId = (Long) userIdObj;
        } else {
            model.addAttribute("error", "올바른 사용자 ID를 찾을 수 없습니다.");
            return "/user/account";
        }

        // API 요청 URL
        String apiUrl = apiBaseUrl + "/api/user";
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            UserInfoRequestDto requestDto = new UserInfoRequestDto(userId);
            HttpEntity<UserInfoRequestDto> requestEntity = new HttpEntity<>(requestDto, headers);

            ResponseEntity<String> response = restTemplate.exchange(
                    apiUrl,
                    HttpMethod.GET,
                    requestEntity,
                    String.class
            );
            
            JsonNode rootNode = objectMapper.readTree(response.getBody());
            JsonNode recruitmentList = rootNode.path("data").path("userInfo");

            if (response.getBody() != null && response.getBody() != null) {
                model.addAttribute("id", recruitmentList.path("id").asText());
                model.addAttribute("name", recruitmentList.path("name").asText());
                model.addAttribute("email", recruitmentList.path("email").asText());
                model.addAttribute("phone", recruitmentList.path("phone").asText());
                model.addAttribute("ceoNum", recruitmentList.path("ceoNum").asText());
                model.addAttribute("company", recruitmentList.path("company").asText());
                
                JsonNode lastModifiedDateNode = recruitmentList.path("lastModifiedDate");
                if (!lastModifiedDateNode.isMissingNode() && !lastModifiedDateNode.isNull()) {
                    model.addAttribute("lastModifiedDate", lastModifiedDateNode.asText());
                } else {
                    model.addAttribute("lastModifiedDate", "N/A");
                }
            }


        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "회원 정보를 불러오는 중 오류가 발생했습니다.");
        }

        return "/user/account";
    }
}
