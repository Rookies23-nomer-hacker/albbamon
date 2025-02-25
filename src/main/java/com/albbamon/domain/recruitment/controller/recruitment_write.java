package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.recruitment.dto.request.CreateRecruitmentRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;

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
    public String createRecruitment(@ModelAttribute CreateRecruitmentRequestDto createRecruitmentRequestDto,
                                    HttpServletRequest httpServletRequest,
                                    Model model) {
        System.out.println("************************ " + httpServletRequest.getSession().getId());
        System.out.println("************************ " + Arrays.stream(httpServletRequest.getCookies()).toList().toString());
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.add("Cookie", "JSESSIONID=" + httpServletRequest.getSession().getId());
        HttpSession session = httpServletRequest.getSession(false);
        if(session.getAttribute("userid") == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }

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
