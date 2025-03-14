package com.albbamon.domain.post.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PostListController {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public PostListController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/post")
    public String getAllPosts(@RequestParam(name = "page", defaultValue = "0") int page,
                              @RequestParam(name = "size", defaultValue = "10") int size,
                              Model model, HttpSession session) {
        String post_url = apiBaseUrl + "/api/post/list?page=" + page + "&size=" + size;
        String notice_url = apiBaseUrl + "/api/notice";
        try {
	        ResponseEntity<String> response_notice = restTemplate.exchange(notice_url,
	                HttpMethod.GET,
	                null,
	                String.class
	                );
			if (response_notice.getStatusCode() == HttpStatus.OK) {
	            ObjectMapper mapper = new ObjectMapper();
	            JsonNode rootNode = mapper.readTree(response_notice.getBody());
	            JsonNode noticeListNode = rootNode.path("noticeList"); // API에서 반환하는 필드명
	            List<Map<String, Object>> noticeList = mapper.convertValue(
	                    noticeListNode,
	                    new com.fasterxml.jackson.core.type.TypeReference<List<Map<String, Object>>>() {}
	            );
	            model.addAttribute("noticeList", noticeList);
			}
        }catch (Exception e) {
        	e.printStackTrace();
        }
        ResponseEntity<String> response = restTemplate.getForEntity(post_url, String.class);
        List<Map<String, String>> posts = new ArrayList<>();
        int totalPages = 1;
        int currentPage = page;
        
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(response.getBody());
            JsonNode postList = root.path("data").path("postList");

            for (JsonNode postNode : postList) {
                Map<String, String> post = new HashMap<>();
                post.put("id", String.valueOf(postNode.path("postId").asInt()));
                post.put("title", postNode.path("title").asText());
                post.put("contents", postNode.path("contents").asText());
                post.put("userName", postNode.path("userName").asText());
                post.put("createDate", postNode.path("createDate").asText());
                posts.add(post);
            }

            JsonNode pageInfo = root.path("data").path("pageInfo");
            totalPages = pageInfo.path("totalPages").asInt();

        } catch (Exception e) {
            e.printStackTrace();
        }

        int groupSize = 10;
        int currentGroup = (page - 1) / groupSize;
        int startPage = currentGroup * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);
        

        int nextGroupPage = Math.min(endPage + 1, totalPages);
        int prevGroupPage = Math.max(startPage - groupSize, 1);

        model.addAttribute("isLoggedIn", session.getAttribute("userid") != null);
        model.addAttribute("posts", posts);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("pageSize", size);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("nextGroupPage", nextGroupPage);
        model.addAttribute("prevGroupPage", prevGroupPage);
        model.addAttribute("groupSize", groupSize);

        return "post/post_list";
    }
    
    @GetMapping("/post/search")
    public String searchPosts(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
        String url = apiBaseUrl + "/api/post/search?keyword=" + keyword;
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        List<Map<String, String>> posts = new ArrayList<>();
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode postList = mapper.readTree(response.getBody());

            for (JsonNode postNode : postList) {
                Map<String, String> post = new HashMap<>();
                post.put("id", String.valueOf(postNode.path("postId").asInt()));
                post.put("title", postNode.path("title").asText());
                post.put("contents", postNode.path("contents").asText());
                post.put("userName", postNode.path("userName").asText());
                post.put("createDate", postNode.path("createDate").asText());

                posts.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("posts", posts);
        model.addAttribute("isLoggedIn", session.getAttribute("userid") != null);

        return "post/post_list";
    }
}