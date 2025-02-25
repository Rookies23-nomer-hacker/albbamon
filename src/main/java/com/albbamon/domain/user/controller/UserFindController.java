package com.albbamon.domain.user.controller;
import java.util.List;//리스트형태로 받기위해 임포트

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;//리스트형태로 받기위해
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod; //리스트형태로 받기위해
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder; //리스트형태로 받기위해임포트

import com.albbamon.domain.user.dto.request.UserFindRequestDto;
import com.albbamon.domain.user.dto.response.UserFindResponseDto;





@Controller
public class UserFindController {
    @GetMapping("/api/user/find-id")
    public String reg() {
        return "/user/find_id"; // 📌 여기에 해당 HTML 파일이 있어야 함
    }
    //
    @Value("${api.base-url}")
    private String apiBaseUrl;
    
    private final RestTemplate restTemplate = new RestTemplate();
    
    //private final String apiUrl = "http://localhost:8083/api/user/find-id"; // ✅ API 서버 URL
    
    @GetMapping("/find-id")
    public String findUserId(
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam(value = "ceoNum", required = false) String ceoNum,
            Model model) {
    	String apiUrl = apiBaseUrl + "/api/user/find-id";
    	String[] parts = name.split(",", 2);
    	String requestUrl ="";
    	if (phone=="") {
    	    String right = parts[1];
            // API 서버로 요청을 보낼 URL 생성
            requestUrl = apiUrl + "?name=" + right + "&phone=" + phone+"&ceoNum="+ceoNum;
    	}else if(ceoNum=="") {
    		String right = parts[0];
            // API 서버로 요청을 보낼 URL 생성
            requestUrl = apiUrl + "?name=" + right + "&phone=" + phone+"&ceoNum="+ceoNum;
    	}
        System.out.println("📌 API 요청 URL: " + requestUrl);
        try {
            // ✅ API 서버로 GET 요청 보내기 (리스트 형태로 응답 받기)
            ResponseEntity<List<UserFindResponseDto>> response = restTemplate.exchange(
                    requestUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<UserFindResponseDto>>() {}
            );
         // ✅ 응답 데이터 처리
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                List<UserFindResponseDto> users = response.getBody();
                String activeTab = users.get(0).getType();
                model.addAttribute("activeTab", activeTab);
                if (!users.isEmpty()) {
                    // ✅ 이메일 정보만 추출하여 리스트로 변환
                    List<String> emailList = users.stream()
                            .map(UserFindResponseDto::getEmail) // getEmail()만 추출
                            .toList();
                    // ✅ 모델에 이메일 리스트 추가
                    model.addAttribute("emails", emailList);
                    System.out.println("📌 웹 서버에서 최종 반환할 이메일 리스트: " + emailList);
                    return "/user/find_id_result"; // ✅ 성공 시 결과 페이지로 이동
                }
            } else {
                model.addAttribute("errorMsg", "사용자 정보를 찾을 수 없습니다.");
                return "/user/find_id"; // 에러를 보여줄 JSP 페이지
            }
        } catch (Exception e) {
            System.err.println("❌ API 요청 중 오류 발생: " + e.getMessage());
            model.addAttribute("error", "서버와의 통신 중 오류가 발생했습니다.");
        }
        return "/user/find_id_result"; // 실패 시 다시 아이디 찾기 페이지로 이동
    }
    @GetMapping("/api/user/find-pw")
    public String findPwView() {
        return "/user/find_pw"; // 📌 여기에 해당 HTML 파일이 있어야 함
    }
    
    
}
