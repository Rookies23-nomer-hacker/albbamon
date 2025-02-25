package com.albbamon.domain.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.albbamon.domain.post.dto.request.CreatePostRequestDto;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostUpdate {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public PostUpdate(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 📌 글 수정 페이지 이동
    @GetMapping("/api/post/update")
    public String writePage(HttpSession session, Model model) {
        // 세션에서 userid 가져오기
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            System.out.println("세션에서 userid를 찾을 수 없습니다.");
            return "redirect:/api/user/sign-in";
        }

        Long userid = null;

        try {
            // userIdObj가 JSON 형식인지 확인
            String userJson = userIdObj.toString();
            if (userJson.contains("data")) {
                // JSON 파싱
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode jsonNode = objectMapper.readTree(userJson);
                JsonNode dataNode = jsonNode.path("data");

                if (!dataNode.isMissingNode() && !dataNode.isNull()) {
                    userid = dataNode.asLong();
                    System.out.println("파싱된 userid: " + userid);
                } else {
                    System.out.println("JSON 응답에서 userid를 찾을 수 없습니다.");
                    return "redirect:/api/user/sign-in";
                }
            } else {
                // JSON이 아닌 경우 Long으로 변환 시도
                userid = Long.parseLong(userIdObj.toString());
            }

        } catch (Exception e) {
            System.out.println("세션의 userid가 올바르지 않습니다: " + userIdObj);
            e.printStackTrace();
            return "redirect:/api/user/sign-in";
        }

        System.out.println("글쓰기 페이지 - 로그인된 사용자 ID: " + userid);
        return "post/post_write";  // 글쓰기 페이지로 이동
    }


    // 📌 글 수정 처리
    @PostMapping("/api/post/update/{postId:\\d+}")
    public String updatePost(@SessionAttribute(name = "SESSION_NAME") Long userId,
                             @PathVariable("postId") Long postId,
                             @ModelAttribute CreatePostRequestDto createPostRequestDto,
                             @RequestParam(value = "file", required = false) MultipartFile file,
                             Model model) {

        ObjectMapper objectMapper = new ObjectMapper();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);  // JSON으로 전송

        try {
            // 게시글 소유자 검증
            String getUrl = apiBaseUrl + "/api/post/" + postId;
            ResponseEntity<String> getResponse = restTemplate.exchange(getUrl, HttpMethod.GET, null, String.class);

            if (getResponse.getStatusCode() == HttpStatus.OK) {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(getResponse.getBody());
                Long postOwnerId = rootNode.path("data").path("userId").asLong();

                if (!userId.equals(postOwnerId)) {
                    model.addAttribute("error", "수정 권한이 없습니다.");
                    return "error/unauthorized";
                }
            }

            // 파일 정보 출력
            if (file != null && !file.isEmpty()) {
                System.out.println("Uploaded File Name: " + file.getOriginalFilename());
                System.out.println("File Size: " + file.getSize());
                // 파일 처리 로직 추가 (예: 파일 저장 또는 별도 API 전송)
            } else {
                System.out.println("No file uploaded.");
            }

            // JSON 변환
            String body = objectMapper.writeValueAsString(createPostRequestDto);
            System.out.println("수정 데이터 (body): " + body);

            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);

            // PUT 요청
            ResponseEntity<String> response = restTemplate.exchange(apiBaseUrl + "/api/post/" + postId, HttpMethod.PUT, requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                System.out.println("글이 성공적으로 수정되었습니다.");
            } else {
                System.out.println("글 수정 실패: " + response.getStatusCode());
                model.addAttribute("error", "글 수정 실패: " + response.getStatusCode());
                return "error/failed";
            }

        } catch (JsonProcessingException e) {
            e.printStackTrace();
            model.addAttribute("error", "JSON 변환 오류가 발생했습니다.");
            return "error/failed";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "알 수 없는 오류가 발생했습니다.");
            return "error/failed";
        }

        // 글 수정 후 게시글 목록으로 이동
        return "redirect:/api/post";
    }
}
