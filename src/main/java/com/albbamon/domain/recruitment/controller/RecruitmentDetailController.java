package com.albbamon.domain.recruitment.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Controller
public class RecruitmentDetailController {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public RecruitmentDetailController(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/{recruitmentId}")
    public String getRecruitment(@PathVariable("recruitmentId") Long recruitmentId, Model model) {
        Map<String, String> recruitment = new HashMap<>();
        
        try {
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId, String.class);
            JsonNode recruitmentInfo = objectMapper.readTree(responseEntity.getBody()).path("data");

            Long id = recruitmentInfo.path("id").asLong();
            String title = recruitmentInfo.path("title").asText();
            LocalDateTime createDate = LocalDateTime.parse(recruitmentInfo.path("createDate").asText());
            LocalDateTime dueDate = LocalDateTime.parse(recruitmentInfo.path("dueDate").asText());
            String contents = recruitmentInfo.path("contents").asText();
            Integer wage = recruitmentInfo.path("wage").asInt();
            String userName = recruitmentInfo.path("userName").asText();
            String company = recruitmentInfo.path("company").asText();
            String file = recruitmentInfo.path("file").asText();
            
            NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US); // 천 단위 구분 쉼표 추가

            String formattedWage = numberFormat.format(wage); // ✅ 3자리마다 쉼표 추가
            
            recruitment.put("id", String.valueOf(id));
            recruitment.put("title", title);
            recruitment.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
            recruitment.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
            recruitment.put("contents", contents);
            recruitment.put("wage", formattedWage);
            recruitment.put("userName", userName);
            recruitment.put("company", company);
            recruitment.put("file", file);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        
        model.addAttribute("apiBaseUrl", apiBaseUrl);
        model.addAttribute("recruitment", recruitment);

        return "recruitment/recruitment_detail";
    }
}
