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

    @GetMapping("/api/post/update/{postId}")
    public String writePage(@PathVariable("postId") Long postId, HttpSession session, Model model) {
        Object userIdObj = session.getAttribute("userid");

        if (userIdObj == null) {
            return "redirect:/api/user/sign-in";
        }

        try {
            String getUrl = apiBaseUrl + "/api/post/" + postId;
            ResponseEntity<String> getResponse = restTemplate.exchange(getUrl, HttpMethod.GET, null, String.class);

            if (getResponse.getStatusCode() == HttpStatus.OK) {
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(getResponse.getBody());
                JsonNode postNode = rootNode.path("data");
                Map<String, Object> postMap = mapper.convertValue(postNode, Map.class);
                model.addAttribute("post", postMap);
            } else {
                return "redirect:/api/post";
            }

        } catch (Exception e) {
            return "redirect:/api/post";
        }

        return "post/post_update";
    }


    @PostMapping("/api/post/update/{postId:\\d+}")
    public String updatePost(HttpSession session,  
                             @PathVariable("postId") Long postId,
                             @ModelAttribute CreatePostRequestDto createPostRequestDto,
                             @RequestParam(value = "file", required = false) String file,
                             Model model) {

        ObjectMapper objectMapper = new ObjectMapper();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        Object userIdObj = session.getAttribute("userid");
        Long userId = null;

        if (userIdObj instanceof String) {
            userId = Long.parseLong((String) userIdObj);
        } else if (userIdObj instanceof Long) {
            userId = (Long) userIdObj;
        }

        if (userId == null) {
            return "redirect:/api/user/sign-in";  
        }

        try {
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
                model.addAttribute("error", "게시글을 찾을 수 없습니다.");
                return "error/notfound";
            }

            createPostRequestDto.setUserid(userId);

            if (file != null && !file.isEmpty()) {
                createPostRequestDto.setFile(file);
                System.out.println("파일 수정됨: " + file);
            } else {
                createPostRequestDto.setFile(null);
                System.out.println("파일 없음");
            }

            String body = objectMapper.writeValueAsString(createPostRequestDto);
            HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.exchange(apiBaseUrl + "/api/post/update/" + postId, HttpMethod.POST, requestEntity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                System.out.println("✅ 글이 성공적으로 수정되었습니다.");
            } else {
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

        return "redirect:/api/post";
    }
    
    @DeleteMapping("/api/post/delete/{postId}")
    public ResponseEntity<String> deletePost(@PathVariable("postId") Long postId, HttpSession session) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            Object userIdObj = session.getAttribute("userid");
            Long userId = null;

            if (userIdObj instanceof String) {
                userId = Long.parseLong((String) userIdObj);
            } else if (userIdObj instanceof Long) {
                userId = (Long) userIdObj;
            }

            if (userId == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
            }

            String requestBody = objectMapper.writeValueAsString(Map.of("userId", userId));
            HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);
            ResponseEntity<String> response = restTemplate.exchange(
                    apiBaseUrl + "/api/post/delete/" + postId,
                    HttpMethod.DELETE,
                    requestEntity,
                    String.class
            );

            if (response.getStatusCode() == HttpStatus.OK) {
                return ResponseEntity.ok("삭제 성공");
            } else {
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
