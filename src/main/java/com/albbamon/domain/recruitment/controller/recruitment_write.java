package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.recruitment.dto.request.CreateRecruitmentRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

@Controller
public class recruitment_write {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public recruitment_write(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/write")
    public String wrtie() {
        return "recruitment/recruitment_write";
    }

    @PostMapping("/api/recruitment")
    public String createRecruitment(@ModelAttribute CreateRecruitmentRequestDto createRecruitmentRequestDto) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=A7DBE136B1A65FEFD1014A2DE6ECBFDB");

        try {
            body = objectMapper.writeValueAsString(createRecruitmentRequestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(apiBaseUrl + "/api/recruitment", requestEntity, String.class);
        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "redirect:/recruitment/list/my";
    }
}
