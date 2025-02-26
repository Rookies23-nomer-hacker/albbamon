package com.albbamon.domain.recruitment.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
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
import java.util.stream.Collectors;

@Controller
public class recruitment_list {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public recruitment_list(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/list")
    public String list(Model model) {
        List<Map<String, String>> recruitments = new ArrayList<>();
        List<Long> buyerIds = new ArrayList<>();
        
        try {
        	ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/list", String.class);
        	//ResponseEntity<String> responseBuyerEntity = restTemplate.getForEntity(apiBaseUrl + "/api/payment/findUserId", String.class);
        	
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
            //JsonNode rootNode2 = objectMapper.readTree(responseBuyerEntity.getBody());
            /*
            for (JsonNode buyerId : rootNode2) {  // buyerId는 직접 반복문을 사용
                buyerIds.add(buyerId.asLong());
            }
            */
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("recruitmentList", recruitments);  // List 객체 전달
        
        // 아이템 구매자 user id. long -> string으로 
        List<String> buyerIdsString = buyerIds.stream().map(String::valueOf).collect(Collectors.toList());
        model.addAttribute("buyerIds", buyerIdsString);

        return "recruitment/recruitment_list";
    }
}
