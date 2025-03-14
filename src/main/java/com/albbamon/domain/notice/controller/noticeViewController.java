package com.albbamon.domain.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.notice.dto.request.UpdateRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Controller
public class noticeViewController {
	private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;
    
    @Autowired
    public noticeViewController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }
    
	@GetMapping("/notice")
	public String noticeView(HttpSession session,
			Model model) {
		String apiUrl = apiBaseUrl + "/api/notice";
		
		try {
			ResponseEntity<String> response = restTemplate.exchange(apiUrl,
	                HttpMethod.GET,
	                null,
	                String.class
	                );
			if (response.getStatusCode() == HttpStatus.OK) {
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode rootNode = mapper.readTree(response.getBody());
	            JsonNode noticeListNode = rootNode.path("noticeList"); // API에서 반환하는 필드명
	            List<Map<String, Object>> noticeList = mapper.convertValue(
	                    noticeListNode,
	                    new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, Object>>>() {}
	            );
	            model.addAttribute("noticeList", noticeList);
	        } else {
	        }
	    } catch (Exception e) {
	    }
	    return "/notice/noticeView"; // 공지사항 리스트 페이지 반환

	}
	@GetMapping("/notice/{noticeId}")
	public String detailGet(@PathVariable("noticeId") Long noticeId,
			Model model) {
		
		String apiUrl = apiBaseUrl + "/api/notice/" +noticeId;
		System.out.println("d?");
		try {
			ResponseEntity<String> response = restTemplate.exchange(apiUrl,
	                HttpMethod.GET,
	                null,
	                String.class
	                );
			
			if (response.getStatusCode() == HttpStatus.OK) {
	            // JSON 파싱
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode noticeNode = new ObjectMapper().readTree(response.getBody()).path("notice");
	            // Map으로 변환
	            Map<String, Object> notice = mapper.convertValue(
	            		noticeNode,
	                    new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {}
	            );
	            model.addAttribute("notice",notice);
	        } else {
	            model.addAttribute("notice", null);
	            model.addAttribute("errorMessage", "공지사항을 불러오는 데 실패했습니다.");
	        }

	    } catch (Exception e) {
	        model.addAttribute("notice", null);
	        model.addAttribute("errorMessage", "공지사항 조회 중 오류가 발생했습니다.");
	        e.printStackTrace(); // 로그 확인용
	    }
	    return "/notice/noticeDetail";
	}
	@GetMapping("/notice/update/{noticeId}")
	public String updateGet(@PathVariable("noticeId") Long noticeId,
			Model model) {
		String apiUrl = apiBaseUrl + "/api/notice/" +noticeId;
		try {
			ResponseEntity<String> response = restTemplate.exchange(apiUrl,
	                HttpMethod.GET,
	                null,
	                String.class
	                );			
			if (response.getStatusCode() == HttpStatus.OK) {
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode noticeNode = new ObjectMapper().readTree(response.getBody()).path("notice");
	            Map<String, Object> notice = mapper.convertValue(
	            		noticeNode,
	                    new com.fasterxml.jackson.core.type.TypeReference<Map<String, Object>>() {}
	            );
	            model.addAttribute("notice",notice);
	        } else {
	            model.addAttribute("notice", null);
	            model.addAttribute("errorMessage", "공지사항을 불러오는 데 실패했습니다.");
	        }

	    } catch (Exception e) {
	        model.addAttribute("notice", null);
	        model.addAttribute("errorMessage", "공지사항 조회 중 오류가 발생했습니다.");
	        e.printStackTrace(); // 로그 확인용
	    }
		
		return "/notice/noticeUpdate";
	}
	@PostMapping("/notice/{noticeId}")
	public String updatePost(HttpSession session,  
            @PathVariable("noticeId") Long noticeId,
            @ModelAttribute UpdateRequestDto UpdateRequestDto,
            Model model) {
		System.out.println(session.getAttribute("adminId"));
		if(session.getAttribute("adminId").equals("admin")) {
			System.out.println(noticeId);
		}
	    try {
	        String apiUrl = apiBaseUrl + "/api/notice/" + noticeId;

	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);


	        ObjectMapper mapper = new ObjectMapper();
	        String requestBody = mapper.writeValueAsString(UpdateRequestDto);

	        HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

	        ResponseEntity<String> response = restTemplate.exchange(
	                apiUrl,
	                HttpMethod.POST,
	                requestEntity,
	                String.class
	        );

	        // 응답 코드에 따라 분기
	        if (response.getStatusCode() == HttpStatus.OK) {
	            return "redirect:/api/notice";
	        } else {
	            // 실패 시: 에러 메시지와 함께 수정 페이지로
	            model.addAttribute("errorMessage", "공지사항 수정에 실패했습니다.");
	            return "error/failed";
	        }

	    } catch (JsonProcessingException e) {
	        model.addAttribute("errorMessage", "데이터 처리 중 오류가 발생했습니다.");
	        return "error/failed";

	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "알 수 없는 오류가 발생했습니다.");
	        return "error/failed";
	    }
	}
}