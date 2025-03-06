package com.albbamon.domain.post.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;

@Controller
public class PostDetailController {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public PostDetailController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/post/{postId:\\d+}")
    public String getPostById(@PathVariable("postId") int postId, Model model, HttpSession session) {
        String url = apiBaseUrl + "/api/post/" + postId;
        ResponseEntity<String> response = null;

        try {
            // GET 요청 수행
            response = restTemplate.exchange(url, HttpMethod.GET, null, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                // JSON 파싱
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(response.getBody());
                JsonNode postNode = rootNode.path("data");

                // 게시글 정보 추출
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
                String file = postNode.path("file").asText();
                String createDate = postNode.path("createDate").asText();
                String userName = postNode.path("userName").asText();
                String userId = postNode.path("userId").asText(); // 작성자 ID 추출

                // 모델에 데이터 추가
                Map<String, String> post = new HashMap<>();
                post.put("postId", String.valueOf(postId));  
                post.put("title", title);
                post.put("contents", contents);
                post.put("file", file);
                post.put("userName", userName);
                post.put("userId", userId); // 작성자 ID 추가
                post.put("createDate", createDate.substring(0,10) + ' ' + createDate.substring(11, 16));

                model.addAttribute("post", post);
                model.addAttribute("apiBaseUrl", apiBaseUrl);

                // 세션에서 사용자 ID 가져오기 (for 비교)
                Object sessionUserId = session.getAttribute("userid");
                model.addAttribute("sessionUserId", sessionUserId);
            } else {
                model.addAttribute("error", "게시글을 불러오는 데 실패했습니다.");
            }

        } catch (HttpClientErrorException e) {
            model.addAttribute("error", "요청 중 오류가 발생했습니다. (" + e.getStatusCode() + ")");
        } catch (Exception e) {
            model.addAttribute("error", "알 수 없는 오류가 발생했습니다.");
        }

        // post_detail.jsp로 이동
        return "post/post_detail";
    }
}
