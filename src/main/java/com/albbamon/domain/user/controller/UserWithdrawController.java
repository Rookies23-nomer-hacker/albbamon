package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.JdkClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.albbamon.domain.user.dto.request.UserWithdrawRequestDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserWithdrawController {

    @Value("${api.base-url}")
    private String apiBaseUrl;

    private final RestTemplate restTemplate = new RestTemplate(new JdkClientHttpRequestFactory());

    @GetMapping("/user/withdraw")
    public String withdrawUser(HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userid") == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "redirect:/login";
        }
        Object userIdObj = session.getAttribute("userid");
        Long userId = null;
        if (userIdObj instanceof String) {
            userId = Long.parseLong((String) userIdObj);
        } else if (userIdObj instanceof Long) {
            userId = (Long) userIdObj;
        } else {
            model.addAttribute("error", "올바른 사용자 ID를 찾을 수 없습니다.");
            return "/user/account";
        }

        String apiUrl = apiBaseUrl + "/api/user/withdraw";

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            UserWithdrawRequestDto requestDto = new UserWithdrawRequestDto(userId);
            HttpEntity<UserWithdrawRequestDto> requestEntity = new HttpEntity<>(requestDto, headers);

            ResponseEntity<String> response = restTemplate.exchange(
                apiUrl,
                HttpMethod.GET,
                requestEntity,
                String.class
            );

            if (response.getStatusCode().is2xxSuccessful()) {
                session.invalidate(); //세션 삭제
                redirectAttributes.addFlashAttribute("alertMessage", "회원 탈퇴가 완료되었습니다.");
                return "redirect:/user/account"; //메인 페이지로 이동
            } else {
                model.addAttribute("error", "회원 탈퇴에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "서버 오류가 발생했습니다.");
        }

        return "user/account"; //오류 발생 시 회원 정보 페이지 유지
    }
}
