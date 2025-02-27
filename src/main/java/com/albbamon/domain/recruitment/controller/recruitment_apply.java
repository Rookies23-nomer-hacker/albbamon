package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.user.dto.request.UserRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import java.text.NumberFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Locale;
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
    public String applyInfo(@PathVariable("recruitmentId") Long recruitmentId,
                            HttpServletRequest request,
                            Model model) {
        HttpSession session = request.getSession();
        if(session.getAttribute("userid") == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }
        Long userId = Long.valueOf((String) session.getAttribute("userid"));

        Map<String, String> recruitment = new HashMap<>();
        Map<String, String> user = new HashMap<>();
        boolean resumeExists = true;
        boolean isApplied = false;

        try {
            // recruitment
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


            // user info
            RestTemplate userRestTemplate = new RestTemplate(new JdkClientHttpRequestFactory());
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            UserRequestDto userRequestDto = UserRequestDto.of(userId);
            body = objectMapper.writeValueAsString(userRequestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> userResponseEntity = userRestTemplate.exchange(apiBaseUrl + "/api/user", HttpMethod.GET, requestEntity, String.class);
            JsonNode userInfo = objectMapper.readTree(userResponseEntity.getBody()).path("data").path("userInfo");

            String name = userInfo.path("name").asText();
            String email = userInfo.path("email").asText();
            String phone = userInfo.path("phone").asText();
            System.out.println("이거ㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓㅓ:" + name);

            user.put("name", name);
            user.put("email", email);
            user.put("phone", phone);

            // isApplied
            try {
                isApplied = userRestTemplate.exchange(apiBaseUrl + "/api/recruitment/" + recruitmentId + "/apply/check", HttpMethod.GET, requestEntity, Boolean.class).getBody();
            } catch (Exception e) {
                resumeExists = false;
            }

        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        model.addAttribute("recruitment", recruitment);
        model.addAttribute("user", user);
        model.addAttribute("resumeExists", resumeExists);
        model.addAttribute("isApplied", isApplied);
        model.addAttribute("success", false);

        return "recruitment/recruitment_apply";
    }

    @GetMapping("/recruitment/{recruitmentId}/apply")
    public String createApply(@PathVariable("recruitmentId") final Long recruitmentId,
                              HttpServletRequest request,
                              Model model) {
        HttpSession session = request.getSession();
        if(session.getAttribute("userid") == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }
        Long userId = Long.valueOf((String) session.getAttribute("userid"));

        boolean success = false;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            UserRequestDto requestDto = UserRequestDto.of(userId);
            body = objectMapper.writeValueAsString(requestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            restTemplate.postForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId + "/apply", requestEntity, String.class);
            success = true;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            success = false;
        }

        model.addAttribute("success", success);

        return "redirect:/recruitment/list";
    }
}
