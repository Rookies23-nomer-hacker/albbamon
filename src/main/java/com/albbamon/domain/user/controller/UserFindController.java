package com.albbamon.domain.user.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import com.albbamon.domain.user.dto.response.UserFindResponseDto;


@Controller
public class UserFindController {
    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @GetMapping("/user/find-id")
    public String reg() {
        return "/user/find_id";
    }
    
    @GetMapping("/find-id")
    public String findUserId(@RequestParam(value = "name", required = false) String name,
                             @RequestParam(value = "phone", required = false) String phone,
                             @RequestParam(value = "ceoNum", required = false) String ceoNum,
                             Model model) {
    	String apiUrl = apiBaseUrl + "/api/user/find-id";
    	String[] parts = name.split(",", 2);
    	String requestUrl ="";
    	if (phone=="") {
    	    String right = parts[1];
            requestUrl = apiUrl + "?name=" + right + "&phone=" + phone+"&ceoNum="+ceoNum;
    	} else if(ceoNum=="") {
    		String right = parts[0];
            requestUrl = apiUrl + "?name=" + right + "&phone=" + phone+"&ceoNum="+ceoNum;
    	}
        try {
            ResponseEntity<List<UserFindResponseDto>> response = restTemplate.exchange(
                    requestUrl,
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<List<UserFindResponseDto>>() {}
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                List<UserFindResponseDto> users = response.getBody();
                String activeTab = users.get(0).getType();
                model.addAttribute("activeTab", activeTab);
                if (!users.isEmpty()) {
                    List<String> emailList = users.stream()
                            .map(UserFindResponseDto::getEmail)
                            .toList();
                    model.addAttribute("emails", emailList);
                    return "/user/find_id_result";
                }
            } else {
                model.addAttribute("errorMsg", "사용자 정보를 찾을 수 없습니다.");
                return "/user/find_id";
            }
        } catch (Exception e) {
            model.addAttribute("error", "서버와의 통신 중 오류가 발생했습니다.");
        }
        return "/user/find_id_result";
    }

    @GetMapping("/user/find-pw")
    public String findPwView() {
        return "/user/find_pw";
    }
    
}
