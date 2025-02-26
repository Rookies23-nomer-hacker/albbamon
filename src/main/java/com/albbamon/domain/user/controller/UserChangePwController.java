package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.user.dto.request.ChangePwRequestDto;
import com.albbamon.domain.user.dto.response.ChangePwResponseDto;
import com.albbamon.domain.user.entity.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.ui.Model;

@Controller
public class UserChangePwController {
	@GetMapping("/api/user/change-pw")
	public String viewChangePw(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		//세션없는 사용자는 메인페이지로 이동
		if (session == null || session.getAttribute("userid") == null) {
			System.out.println("asdf");
			return "redirect:/";
		}
		return "/user/changepw";
	}
	 //@Value("http://localhost:60085")
    @Value("${api.base-url}")
    private String apiBaseUrl;
	@PostMapping("/change-pw")
	public String changePassword(
	        @RequestParam("passwd") String passwd,
	        @RequestParam("newpasswd") String newpasswd,
	        @RequestParam("newpasswdcheck") String newpasswdcheck,
	        HttpServletRequest request,
	        Model model) {
	    System.out.println("📌 현재 비밀번호: " + passwd);
	    System.out.println("📌 새 비밀번호: " + newpasswd);
	    System.out.println("📌 새 비밀번호 확인: " + newpasswdcheck);
	    HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
  
        
	    HttpSession session = request.getSession(false); // 기존 세션 유지
        if (session == null) {
            session = request.getSession(); // 새 세션 생성 (필요할 때만)
        }
        System.out.println(session.getAttribute("userid"));
        Object userIdObj = session.getAttribute("userid");
        Long userId = null;

        if (userIdObj instanceof String) {
            userId = Long.parseLong((String) userIdObj);
        } else if (userIdObj instanceof Long) {
            userId = (Long) userIdObj;
        } else {
            throw new IllegalArgumentException("세션에서 올바른 userId를 찾을 수 없습니다.");
        }
        System.out.println("testet"+userId);
        
	    //새 비밀번호와 새 비밀번호 확인 일치 여부 검증하는 부분.
	    if (!newpasswd.equals(newpasswdcheck)) {
	        model.addAttribute("error", "새 비밀번호와 확인 비밀번호가 일치하지 않습니다.");
	        return "user/changepw"; // 비밀번호 변경 페이지로 다시 이동
	    }
	    //비밀번호 보안 정책 부분 취약하게 할시 삭제
//	    if (!isValidPassword(newpasswd)) {
//	        model.addAttribute("error", "비밀번호는 8~16자의 영문 대소문자, 숫자, 특수문자를 포함해야 합니다.");
//	        System.out.println("취약합니다.");
//	        return "/user/changepw";
//	    }
	    
	    String apiUrl = apiBaseUrl + "/api/user/change-pw";
	    System.out.println("testet"+userId);
	 // ✅ ChangePwRequestDto 객체 생성
	    ChangePwRequestDto requestDto = new ChangePwRequestDto(userId, passwd, newpasswd);


	    // ✅ 요청 객체 생성
	    HttpEntity<ChangePwRequestDto> requestEntity = new HttpEntity<>(requestDto, headers);
	    RestTemplate restTemplate = new RestTemplate();
	    
	    try {
	    	System.out.println("testet"+userId);
	        ResponseEntity<ChangePwResponseDto> response = restTemplate.exchange(
	                apiUrl,
	                HttpMethod.POST,
	                requestEntity,
	                ChangePwResponseDto.class
	        );

	        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
	            model.addAttribute("success", response.getBody().getMessage());
	            return "change-pw-success"; // ✅ 성공 시 결과 페이지
	        } else {
	            model.addAttribute("error", "비밀번호 변경 실패: " + response.getBody().getMessage());
	        }
	    } catch (Exception e) {
	        model.addAttribute("error", "서버와의 통신 중 오류가 발생했습니다.");
	        System.err.println("❌ API 요청 중 오류 발생: " + e.getMessage());
	    }

	    return "password-change-result";  // 결과를 보여줄 JSP 페이지
	}
	//비밀번호 보안 정책 검증 메서드
	private boolean isValidPassword(String password) {
	    String passwordPattern = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+{}:;<>,.?/~`]).{8,16}$";
	    return password.matches(passwordPattern);
	}
	
}
