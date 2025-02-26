package com.albbamon.domain.post.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

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
    @GetMapping("/api/post/update/{postId}")
    public String writePage(@PathVariable("postId") Long postId, HttpSession session, Model model) {
        // ✅ 세션에서 userid 가져오기
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            System.out.println("❌ 세션에서 userid를 찾을 수 없습니다. 로그인 페이지로 이동");
            return "redirect:/api/user/sign-in";
        }

        try {
            // ✅ 게시글 정보 불러오기
            String getUrl = apiBaseUrl + "/api/post/" + postId;
            ResponseEntity<String> getResponse = restTemplate.exchange(getUrl, HttpMethod.GET, null, String.class);

            if (getResponse.getStatusCode() == HttpStatus.OK) {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(getResponse.getBody());
                JsonNode postNode = rootNode.path("data");

                // ✅ ObjectNode를 Map으로 변환
                Map<String, Object> postMap = mapper.convertValue(postNode, Map.class);
                model.addAttribute("post", postMap);  // Map으로 전달
            } else {
                System.out.println("❌ 게시글 정보를 불러오지 못했습니다: " + getResponse.getStatusCode());
                return "redirect:/api/post";
            }

        } catch (Exception e) {
            System.out.println("❌ 게시글 정보를 불러오는 중 오류 발생: " + e.getMessage());
            return "redirect:/api/post";
        }

        System.out.println("✅ 글 수정 페이지 이동 - 게시글 ID: " + postId);
        return "post/post_update";  // ✅ 뷰 템플릿 렌더링
    }


    // 📌 글 수정 처리
    @PostMapping("/api/post/update/{postId:\\d+}")
    public String updatePost(HttpSession session,  
                             @PathVariable("postId") Long postId,
                             @ModelAttribute CreatePostRequestDto createPostRequestDto,
                             @RequestParam(value = "file", required = false) String file,
                             Model model) {

        ObjectMapper objectMapper = new ObjectMapper();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // ✅ 세션에서 userId 가져오기
        Object userIdObj = session.getAttribute("userid");
        Long userId = null;

        if (userIdObj instanceof String) {
            userId = Long.parseLong((String) userIdObj);  // ✅ String → Long 변환
        } else if (userIdObj instanceof Long) {
            userId = (Long) userIdObj;  // ✅ 이미 Long이면 그대로 사용
        }

        if (userId == null) {
            System.out.println("❌ 세션에서 userId를 찾을 수 없습니다. 로그인 필요");
            return "redirect:/api/user/sign-in";  
        }

        System.out.println("✅ 수정 요청 - 로그인된 사용자 ID: " + userId);

        try {
            // ✅ 게시글 소유자 검증
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
            } else {
                System.out.println("게시글 소유자 검증 실패: " + getResponse.getStatusCode());
                model.addAttribute("error", "게시글을 찾을 수 없습니다.");
                return "error/notfound";
            }

            // ✅ userId를 DTO에 추가
            createPostRequestDto.setUserid(userId);

            // ✅ 파일 정보 처리
            if (file != null && !file.isEmpty()) {
                createPostRequestDto.setFile(file);
                System.out.println("파일 수정됨: " + file);
            } else {
                createPostRequestDto.setFile(null);
                System.out.println("파일 없음");
            }

            // ✅ JSON 변환
            String body = objectMapper.writeValueAsString(createPostRequestDto);
            System.out.println("수정 데이터 (body): " + body);

            // ✅ PUT 요청 전송
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.exchange(apiBaseUrl + "/api/post/update/" + postId, HttpMethod.POST, requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                System.out.println("✅ 글이 성공적으로 수정되었습니다.");
            } else {
                System.out.println("❌ 글 수정 실패: " + response.getStatusCode());
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

        System.out.println("🚀 수정 완료, /api/post로 리다이렉트합니다.");
        return "redirect:/api/post";  // ✅ 글 수정 후 목록으로 이동
    }
    
    @DeleteMapping("/api/post/delete/{postId}")
    public ResponseEntity<String> deletePost(@PathVariable("postId") Long postId, HttpSession session) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            // ✅ 세션에서 userId 가져오기
            Object userIdObj = session.getAttribute("userid");
            Long userId = null;

            if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);  // ✅ String → Long 변환
            } else if (userIdObj instanceof Long) {
                userId = (Long) userIdObj;  // ✅ 이미 Long이면 그대로 사용
            }

            if (userId == null) {
                System.out.println("❌ 세션에서 userId를 찾을 수 없습니다. 로그인 필요");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            System.out.println("✅ 삭제 요청 - 로그인된 사용자 ID: " + userId + ", Post ID: " + postId);

            // ✅ JSON 변환 (API에 userId 포함)
            String requestBody = objectMapper.writeValueAsString(Map.of("userId", userId));

            // ✅ DELETE 요청 보내기
            HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<String> response = restTemplate.exchange(
                    apiBaseUrl + "/api/post/delete/" + postId,
                    HttpMethod.DELETE,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.OK) {
                System.out.println("✅ 게시글 삭제 성공 - Post ID: " + postId);
                return ResponseEntity.ok("삭제 성공");
            } else {
                System.out.println("❌ 게시글 삭제 실패 - Status: " + response.getStatusCode());
                return ResponseEntity.status(response.getStatusCode()).body("삭제 실패");
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("JSON 변환 오류 발생");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생");
        }
    }





}
