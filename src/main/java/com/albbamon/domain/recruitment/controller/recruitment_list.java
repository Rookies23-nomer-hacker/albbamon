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
        int totalPages = 1;
        int currentPage = page;

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

            // ✅ 페이징 정보 API 응답에서 직접 가져오기
            JsonNode pageInfo = root.path("data").path("pageInfo");
            totalPages = pageInfo.path("totalPages").asInt();

        } catch (Exception e) {
            e.printStackTrace();
        }

     // ✅ 페이징 그룹 계산 (10개씩)
        int groupSize = 10;
        int currentGroup = (currentPage - 1) / groupSize;
        int startPage = currentGroup * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);

        // ✅ Model에 값 전달
        model.addAttribute("recruitmentList", recruitments);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("groupSize", groupSize);
        model.addAttribute("pageSize", size);

        // ✅ 디버깅 로그 출력
        System.out.println("Pagination: startPage=" + startPage + ", endPage=" + endPage + ", currentPage=" + currentPage + ", pageSize=" + size);

        return "recruitment/recruitment_list";
    }



//    @GetMapping("/recruitment/list")
//    public String list(Model model) {
//        List<Map<String, String>> recruitments = new ArrayList<>();
//        	
//        try {
//        	ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/list", String.class);
//            JsonNode recruitmentList = objectMapper.readTree(responseEntity.getBody()).path("data").path("recruitmentList");
//            System.out.println(recruitmentList);
//            for(JsonNode recruitment: recruitmentList) {
//                Integer id = recruitment.path("id").asInt();
//                String title = recruitment.path("title").asText();
//                LocalDateTime createDate = LocalDateTime.parse(recruitment.path("createDate").asText());
//                LocalDateTime dueDate = LocalDateTime.parse(recruitment.path("dueDate").asText());
//                String contents = recruitment.path("content").asText();
//                Integer wage = recruitment.path("wage").asInt();
//                String userName = recruitment.path("userName").asText();
//                String company = recruitment.path("company").asText();
//                String file = recruitment.path("file").asText();
//                String item = recruitment.path("item").asText();
//
//                Map<String, String> r = new HashMap<>();
//                
//                NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US); // 천 단위 구분 쉼표 추가
//
//                String formattedWage = numberFormat.format(wage); // ✅ 3자리마다 쉼표 추가
//                r.put("id", String.valueOf(id));
//                r.put("title", title);
//                r.put("createDate", createDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
//                r.put("dueDate", dueDate.format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH:mm")));
//                r.put("contents", contents);
//                r.put("wage", formattedWage);
//                r.put("userName", userName);
//                r.put("company", company);
//                r.put("file", file);
//                r.put("item", item);
//                recruitments.add(r);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        model.addAttribute("recruitmentList", recruitments);  // List 객체 전달
//        
//        return "recruitment/recruitment_list";
//    }
}
