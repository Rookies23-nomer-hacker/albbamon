package com.albbamon.domain.recruitment.controller;

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
import java.util.*;

@Controller
public class recruitment_list_my {
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public recruitment_list_my(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/list/my")
    public String myList(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Long userId = Long.valueOf((String) session.getAttribute("userid"));
        if(userId == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }

        List<Map<String, String>> recruitments = new ArrayList<>();

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            UserRequestDto userRequestDto = UserRequestDto.of(userId);
            body = objectMapper.writeValueAsString(userRequestDto);
            HttpEntity<String> httpEntity = new HttpEntity<>(body, headers);

            RestTemplate restTemplate = new RestTemplate(new JdkClientHttpRequestFactory());
            ResponseEntity<String> responseEntity = restTemplate.exchange(apiBaseUrl + "/api/recruitment/list/my", HttpMethod.GET, httpEntity, String.class);
            JsonNode rootNode = objectMapper.readTree(responseEntity.getBody());
            JsonNode recruitmentList = rootNode.path("data").path("recruitmentList");

            for(JsonNode recruitment: recruitmentList) {
                Integer id = recruitment.path("id").asInt();
                String title = recruitment.path("title").asText();
                LocalDateTime dueDate = LocalDateTime.parse(recruitment.path("dueDate").asText());
                String contents = recruitment.path("content").asText();
                Integer wage = recruitment.path("wage").asInt();
                String userName = recruitment.path("userName").asText();

                Map<String, String> r = new HashMap<>();
                r.put("id", String.valueOf(id));
                r.put("title", title);
                r.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                r.put("contents", contents);
                r.put("wage", String.valueOf(wage));
                r.put("userName", userName);
                recruitments.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("recruitmentList", recruitments);  // List 객체 전달

        return "recruitment/recruitment_list_my";
    }
}
