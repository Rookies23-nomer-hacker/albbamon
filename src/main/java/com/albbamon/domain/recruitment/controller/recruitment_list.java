package com.albbamon.domain.recruitment.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Controller
public class recruitment_list {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public recruitment_list(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }
    @GetMapping("/recruitment/list")
    public String list(
            @RequestParam(value = "page", defaultValue = "1") int page,  // ✅ 기본값 1로 설정
            @RequestParam(value = "size", defaultValue = "10") int size,
            Model model) {

        // ✅ API 요청 시 `page - 1` 적용 (Spring Pageable은 0부터 시작)
        String url = apiBaseUrl + "/api/recruitment/list?page=" + page + "&size=" + size;
        System.out.println(url);
        ResponseEntity<String> responseEntity = restTemplate.getForEntity(url, String.class);

        System.out.println("++++ API 응답: " + responseEntity.getBody());

        List<Map<String, String>> recruitments = new ArrayList<>();
        int groupSize = 10; // 한 그룹에 표시할 페이지 개수
        int totalPages = 1;

        try {
            JsonNode root = objectMapper.readTree(responseEntity.getBody());

            // ✅ 채용 공고 리스트 추출
            JsonNode recruitmentList = root.path("data").path("recruitmentList");

            for (JsonNode recruitment : recruitmentList) {
                Integer id = recruitment.path("id").asInt();
                String title = recruitment.path("title").asText();
                LocalDateTime createDate = LocalDateTime.parse(recruitment.path("createDate").asText());
                LocalDateTime dueDate = LocalDateTime.parse(recruitment.path("dueDate").asText());
                String contents = recruitment.path("content").asText();
                Integer wage = recruitment.path("wage").asInt();
                String userName = recruitment.path("userName").asText();
                String company = recruitment.path("company").asText();
                String file = recruitment.path("file").asText();
                String item = recruitment.path("item").asText();

                Map<String, String> r = new HashMap<>();
                NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);
                String formattedWage = numberFormat.format(wage);

                r.put("id", String.valueOf(id));
                r.put("title", title);
                r.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                r.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
                r.put("contents", contents);
                r.put("wage", formattedWage);
                r.put("userName", userName);
                r.put("company", company);
                r.put("file", file);
                r.put("item", item);

                recruitments.add(r);
            }


            JsonNode pageInfo = root.path("data").path("pageInfo");
            totalPages = pageInfo.path("totalPages").asInt();

        } catch (Exception e) {
            e.printStackTrace();
        }

        int currentGroup = (page - 1) / groupSize;
        int startPage = currentGroup * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);
        

        int nextGroupPage = Math.min(endPage + 1, totalPages);
        int prevGroupPage = Math.max(startPage - groupSize, 1);


        model.addAttribute("recruitmentList", recruitments);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("nextGroupPage", nextGroupPage);
        model.addAttribute("prevGroupPage", prevGroupPage);
        model.addAttribute("groupSize", groupSize);
        return "recruitment/recruitment_list";
    }
}
