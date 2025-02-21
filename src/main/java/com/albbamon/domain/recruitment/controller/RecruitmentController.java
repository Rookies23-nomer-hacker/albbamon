package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.recruitment.dto.request.CreateRecruitmentRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class RecruitmentController {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public RecruitmentController(RestTemplate restTemplate, ObjectMapper objectMapper) {
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

    @GetMapping("/recruitment/list")
    public String list(Model model) {
        List<Map<String, String>> recruitments = new ArrayList<>();
        List<Long> buyerIds = new ArrayList<>();
        
        try {
        	ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/list", String.class);
        	ResponseEntity<String> responseBuyerEntity = restTemplate.getForEntity(apiBaseUrl + "/api/payment/findUserId", String.class);
        	
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
            
            
            // 아이템 구매자 user id
            JsonNode rootNode2 = objectMapper.readTree(responseBuyerEntity.getBody());
            
            for (JsonNode buyerId : rootNode2) {  // buyerId는 직접 반복문을 사용
                buyerIds.add(buyerId.asLong());
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("recruitmentList", recruitments);  // List 객체 전달
        
        // 아이템 구매자 user id. long -> string으로 
        List<String> buyerIdsString = buyerIds.stream().map(String::valueOf).collect(Collectors.toList());
        model.addAttribute("buyerIds", buyerIdsString);

        return "recruitment/recruitment_list";
    }

    @GetMapping("/recruitment/list/my")
    public String myList(Model model) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=A7DBE136B1A65FEFD1014A2DE6ECBFDB");
        HttpEntity<String> httpEntity = new HttpEntity<>(headers);

        List<Map<String, String>> recruitments = new ArrayList<>();

        try {
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
