package com.albbamon.domain.apply.controller;

import com.albbamon.domain.user.dto.request.UserRequestDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class apply_list {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public apply_list(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/apply/list")
    public String applyList(HttpServletRequest request,
                            Model model) {
        HttpSession session = request.getSession();
        Long userId = Long.valueOf((String) session.getAttribute("userid"));
        if(userId == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }

        List<Map<String, String>> applyList = new ArrayList<>();

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            UserRequestDto userRequestDto = UserRequestDto.of(userId);
            body = objectMapper.writeValueAsString(userRequestDto);
            HttpEntity<String> httpEntity = new HttpEntity<>(body, headers);
            RestTemplate restTemplate = new RestTemplate(new JdkClientHttpRequestFactory());
        	ResponseEntity<String> responseEntity = restTemplate.exchange(apiBaseUrl + "/api/apply", HttpMethod.GET, httpEntity, String.class);
            JsonNode applies = objectMapper.readTree(responseEntity.getBody()).path("data").path("applyList");

            for(JsonNode apply: applies) {
                String id = apply.path("applyId").asText();
                String title = apply.path("recruitmentTitle").asText();
                String wage = apply.path("recruitmentWage").asText();
                String company = apply.path("company").asText();
                LocalDateTime createDate = LocalDateTime.parse(apply.path("createDate").asText());
                String status = apply.path("status").asText();

                switch (status) {
                    case "PASSED" -> {
                        status = "합격";
                    }
                    case "FAILED" -> {
                        status = "불합격";
                    }
                    default -> status = "대기중";
                }

                Map<String, String> a = new HashMap<>();
                a.put("id", id);
                a.put("title", title);
                a.put("wage", wage);
                a.put("company", company);
                a.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                a.put("status", status);
                applyList.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("applyList", applyList);

        return "apply/apply_list";
    }
}
