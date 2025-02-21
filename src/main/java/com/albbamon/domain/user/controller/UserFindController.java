/*package com.albbamon.domain.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.albbamon.config.ApiProperties;
import com.albbamon.domain.user.service.UserService;

import lombok.RequiredArgsConstructor;*/

package com.albbamon.domain.user.controller;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.albbamon.domain.user.dto.request.UserFindRequestDto;
import com.albbamon.domain.user.dto.response.UserFindResponseDto;





@Controller
public class UserFindController {
    @GetMapping("/api/user/find-id")
    public String reg() {
        return "/user/user_find_id"; // 📌 여기에 해당 HTML 파일이 있어야 함
    }
    //
    private final RestTemplate restTemplate = new RestTemplate();
    private final String apiUrl = "http://localhost:8083/api/user/find-id"; // ✅ API 서버 URL

    @GetMapping("/find-id")
    public String findUserId(
            @RequestParam("name") String name,
            @RequestParam("phone") String phone,
            Model model) {

        System.out.println("📌 웹 서버에서 받은 데이터: name=" + name + ", phone=" + phone);

        // API 서버로 요청을 보낼 URL 생성
        String requestUrl = apiUrl + "?name=" + name + "&phone=" + phone;

        System.out.println("📌 API 요청 URL: " + requestUrl);

        try {
            // API 서버로 GET 요청 보내기
            ResponseEntity<UserFindResponseDto> response = restTemplate.getForEntity(requestUrl, UserFindResponseDto.class);

            // API 서버에서 받은 응답을 웹 서버에서 처리
            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                model.addAttribute("email", response.getBody().getEmail());
                return "find-id-result"; // 성공하면 결과 페이지로 이동
            } else {
                model.addAttribute("error", "사용자 정보를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            System.err.println("❌ API 요청 중 오류 발생: " + e.getMessage());
            model.addAttribute("error", "서버와의 통신 중 오류가 발생했습니다.");
        }

        return "find-id"; // 실패 시 다시 아이디 찾기 페이지로 이동
    }
}
