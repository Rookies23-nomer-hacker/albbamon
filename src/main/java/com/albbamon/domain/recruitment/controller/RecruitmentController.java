package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.recruitment.dto.request.CreateRecruitmentRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

@Controller
public class RecruitmentController {
    String body;

    @GetMapping("/api/recruitment/write")
    public String wrtie() {
        return "recruitment/recruitment_write";
    }

    @PostMapping("/api/recruitment")
    public String createRecruitment(@ModelAttribute CreateRecruitmentRequestDto createRecruitmentRequestDto) {
        ObjectMapper objectMapper = new ObjectMapper();
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=9DE11CA851C45A26599CC27EB8F386F2");

        try {
            body = objectMapper.writeValueAsString(createRecruitmentRequestDto);
            System.out.println("body = " + body);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.postForEntity("http://localhost:8082/api/recruitment", requestEntity, String.class);
            System.out.println("Response: " + response.getBody());

        } catch (JsonProcessingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "recruitment/recruitment_write";
    }
}
