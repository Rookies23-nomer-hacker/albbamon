package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.user.dto.request.UserRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@Controller
public class recruitment_apply {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public recruitment_apply(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/{recruitmentId}/apply-info")
    public String applyInfo(@PathVariable final Long recruitmentId,
                              HttpServletRequest request,
                              Model model) {
        HttpSession session = request.getSession();
        Long userId = Long.valueOf((String) session.getAttribute("userid"));
        if(userId == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }

        Map<String, String> recruitment = new HashMap<>();

        try {
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId, String.class);
            JsonNode recruitmentInfo = objectMapper.readTree(responseEntity.getBody()).path("data");

            Long id = recruitmentInfo.path("id").asLong();
            String title = recruitmentInfo.path("title").asText();
            LocalDateTime dueDate = LocalDateTime.parse(recruitmentInfo.path("dueDate").asText());
            String contents = recruitmentInfo.path("contents").asText();
            Integer wage = recruitmentInfo.path("wage").asInt();
            String userName = recruitmentInfo.path("userName").asText();

            recruitment.put("id", String.valueOf(id));
            recruitment.put("title", title);
            recruitment.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
            recruitment.put("contents", contents);
            recruitment.put("wage", String.valueOf(wage));
            recruitment.put("userName", userName);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        model.addAttribute("recruitment", recruitment);

        return "recruitment/recruitment_apply";
    }

    @GetMapping("/recruitment/{recruitmentId}/apply")
    public String createApply(@PathVariable final Long recruitmentId,
                              HttpServletRequest request,
                              Model model) {
        HttpSession session = request.getSession();
        Long userId = Long.valueOf((String) session.getAttribute("userid"));
        if(userId == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            UserRequestDto requestDto = UserRequestDto.of(userId);
            body = objectMapper.writeValueAsString(requestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            restTemplate.postForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId + "/apply", requestEntity, String.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return "redirect:/recruitment/list";
    }
}
