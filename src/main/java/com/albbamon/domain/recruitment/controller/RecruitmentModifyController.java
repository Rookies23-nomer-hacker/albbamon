package com.albbamon.domain.recruitment.controller;

import com.albbamon.domain.recruitment.dto.request.UpdateRecruitmentRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RecruitmentModifyController {
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    @Value("${api.base-url}")
    private String apiBaseUrl;
    String body;

    @Autowired
    public RecruitmentModifyController(RestTemplate restTemplate, ObjectMapper objectMapper) {
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/recruitment/{recruitmentId}/modify")
    public String getRecruitment(@PathVariable("recruitmentId") Long recruitmentId, Model model) {
        Map<String, String> recruitment = new HashMap<>();

        try {
            ResponseEntity<String> responseEntity = restTemplate.getForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId, String.class);
            JsonNode recruitmentInfo = objectMapper.readTree(responseEntity.getBody()).path("data");

            Long id = recruitmentInfo.path("id").asLong();
            String title = recruitmentInfo.path("title").asText();
            String dueDate = recruitmentInfo.path("dueDate").asText();
            String contents = recruitmentInfo.path("contents").asText();
            Integer wage = recruitmentInfo.path("wage").asInt();
            String userName = recruitmentInfo.path("userName").asText();

            recruitment.put("id", String.valueOf(id));
            recruitment.put("title", title);
            recruitment.put("dueDate", dueDate);
            recruitment.put("contents", contents);
            recruitment.put("wage", String.valueOf(wage));
            recruitment.put("userName", userName);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        model.addAttribute("recruitment", recruitment);

        return "recruitment/recruitment_modify";
    }

    @PostMapping("/recruitment/{recruitmentId}/modify")
    public String updateRecruitment(@ModelAttribute("updateRecruitmentRequestDto") UpdateRecruitmentRequestDto updateRecruitmentRequestDto,
                                    @PathVariable("recruitmentId") final Long recruitmentId,
                                    HttpServletRequest request,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        if(session.getAttribute("userid") == null) {
            model.addAttribute("NotLogin", 1);
            return "user/login";
        }
        Long userId = Long.valueOf((String) session.getAttribute("userid"));

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            updateRecruitmentRequestDto.setUserId(userId);
            body = objectMapper.writeValueAsString(updateRecruitmentRequestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            restTemplate.postForEntity(apiBaseUrl + "/api/recruitment/" + recruitmentId , requestEntity, String.class);
            redirectAttributes.addFlashAttribute("successMessage", "공고가 성공적으로 수정되었습니다!");
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return "redirect:/recruitment/my";
    }
}
