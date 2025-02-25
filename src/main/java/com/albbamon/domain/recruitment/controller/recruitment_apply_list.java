package com.albbamon.domain.recruitment.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class recruitment_apply_list {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public recruitment_apply_list(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/{recruitmentId}/apply")
    public String applyList(Model model, @PathVariable final Long recruitmentId) {
        List<Map<String, String>> applys = new ArrayList<>();

        try {
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId + "/apply", String.class);
            JsonNode rootNode = objectMapper.readTree(responseEntity.getBody());
            JsonNode applyList = rootNode.path("data").path("applyList");
            System.out.println(applyList.asText());

            for(JsonNode apply: applyList) {
                Integer id = apply.path("applyId").asInt();
                String userName = apply.get("userName").asText();
                String school = apply.path("school").asText();
                String status = apply.path("status").asText();
                String personal = apply.path("personal").asText();
                String workPlaceRegion = apply.path("workPlaceRegion").asText();
                String workPlaceCity = apply.path("workPlaceCity").asText();
                String industryOccupation = apply.path("industryOccupation").asText();
                String employmentType = apply.path("employmentType").asText();
                String workingPeriod = apply.path("workingPeriod").asText();
                String workingDay = apply.path("workingDay").asText();
                String portfoliourl = apply.path("portfoliourl") != null ? apply.path("portfoliourl").asText() : "없음";
                LocalDateTime createDate = LocalDateTime.parse(apply.path("createDate").asText());
                String applyStatus = apply.path("applyStatus").asText();

                Map<String, String> a = new HashMap<>();
                a.put("id", String.valueOf(id));
                a.put("userName", userName);
                a.put("school", school);
                a.put("status", status);
                a.put("personal", personal);
                a.put("workPlaceRegion", workPlaceRegion);
                a.put("workPlaceCity", workPlaceCity);
                a.put("industryOccupation", industryOccupation);
                a.put("employmentType", employmentType);
                a.put("workingPeriod", workingPeriod);
                a.put("workingDay", workingDay);
                a.put("portfoliourl", portfoliourl);
                a.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                a.put("applyStatus", applyStatus);

                applys.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("applyList", applys);  // List 객체 전달

        return "recruitment/recruitment_apply_list";
    }
}
