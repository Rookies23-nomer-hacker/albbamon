package com.albbamon.domain.post.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
public class Postlist {

    private final RestTemplate restTemplate;

    @Value("${api.base-url}")
    private String apiBaseUrl;

    @Autowired
    public Postlist(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 📌 게시글 목록 불러오기 (세션 체크 포함)
    @GetMapping("/api/post")
    public String getAllPosts(
            @RequestParam(name = "page", defaultValue = "0") int page,
            @RequestParam(name = "size", defaultValue = "10") int size,
            Model model, HttpSession session) {
    	System.out.println("page = " + page + " size = " + size);
        // ✅ API 요청 시 `size` 포함하도록 수정
        String url = apiBaseUrl + "/api/post/list?page=" + page + "&size=" + size;
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
<<<<<<< HEAD

        System.out.println("++++ API 응답: " + response.getBody());

=======
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
        List<Map<String, String>> posts = new ArrayList<>();
        int totalPages = 1;
        int currentPage = page;

        try {
            ObjectMapper mapper = new ObjectMapper();
<<<<<<< HEAD
            JsonNode root = mapper.readTree(response.getBody());
=======
            JsonNode postList = mapper.readTree(response.getBody()).path("data").path("postList");
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git

<<<<<<< HEAD
            // ✅ postList에서 게시글 리스트 추출
            JsonNode postList = root.path("data").path("postList");

=======
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
            for (JsonNode postNode : postList) {
<<<<<<< HEAD
=======
                int id = postNode.path("postId").asInt();
                String idStr = String.valueOf(id);
                String title = postNode.path("title").asText();
                String contents = postNode.path("contents").asText();
                String createDate = postNode.path("createDate").asText();
                String userName = postNode.path("userName").asText();

>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
                Map<String, String> post = new HashMap<>();
                post.put("id", String.valueOf(postNode.path("postId").asInt()));
                post.put("title", postNode.path("title").asText());
                post.put("contents", postNode.path("contents").asText());
                post.put("userName", postNode.path("userName").asText());
                post.put("createDate", postNode.path("createDate").asText());
                posts.add(post);
            }

            // ✅ pageInfo에서 페이징 정보 추출
            JsonNode pageInfo = root.path("data").path("pageInfo");
            totalPages = pageInfo.path("totalPages").asInt();

        } catch (Exception e) {
            e.printStackTrace();
        }
<<<<<<< HEAD

=======
        
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
        Object userId = session.getAttribute("userid");
<<<<<<< HEAD
        // ✅ 페이징 그룹 계산 (10개씩)
        int groupSize = 10;
        int currentGroup = (currentPage - 1) / groupSize;
        int startPage = currentGroup * groupSize + 1;
        int endPage = Math.min(startPage + groupSize - 1, totalPages);
=======
        if (userId != null) {
            model.addAttribute("isLoggedIn", true);
        } else {
            model.addAttribute("isLoggedIn", false);
        }
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git

<<<<<<< HEAD
        // ✅ Model에 값 전달
        model.addAttribute("isLoggedIn", session.getAttribute("userid") != null);
=======
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
        model.addAttribute("posts", posts);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("groupSize", groupSize);

<<<<<<< HEAD
        // ✅ 디버깅 로그 출력
        System.out.println("Pagination: startPage=" + startPage + ", endPage=" + endPage + ", currentPage=" + currentPage);

=======
>>>>>>> branch 'main' of https://github.com/Rookies23-nomer-hacker/albbamon.git
        return "post/post_list";
    }
   
//    @GetMapping("/api/post")
//    public String getAllPosts(Model model, HttpSession session) {
//        String url = apiBaseUrl + "/api/post/list";
//        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
//
//        // 전체 JSON 응답 출력 (디버깅용)
//        System.out.println("+++++++++++++++++++++== " + response.getBody());
//
//        List<Map<String, String>> posts = new ArrayList<>();
//
//        try {
//            // JSON 파싱
//            ObjectMapper mapper = new ObjectMapper();
//            JsonNode postList = mapper.readTree(response.getBody());
//
//            // 게시글 리스트 순회
//            for (JsonNode postNode : postList) {
//                int id = postNode.path("postId").asInt();  // 게시글 ID
//                String idStr = String.valueOf(id);        // 문자열로 변환
//                String title = postNode.path("title").asText();
//                String contents = postNode.path("contents").asText();
//                String createDate = postNode.path("createDate").asText();
//                String userName = postNode.path("userName").asText();
//
//                // 각 게시글 정보 출력 (디버깅용)
//                System.out.println("===== Post Item =====");
//                System.out.println("Id: " + idStr);
//                System.out.println("Title: " + title);
//                System.out.println("Contents: " + contents);
//                System.out.println("UserName: " + userName);
//                System.out.println("CreateDate: " + createDate);
//                System.out.println("=====================");
//
//                // Map에 게시글 정보 저장
//                Map<String, String> post = new HashMap<>();
//                post.put("id", idStr);
//                post.put("title", title);
//                post.put("contents", contents);
//                post.put("userName", userName);
//                post.put("createDate", createDate);
//
//                posts.add(post);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        // ✅ 세션 값 확인
//        System.out.println(session.getAttribute("userid"));
//        
//        Object userId = session.getAttribute("userid");
//        if (userId != null) {
//            System.out.println("로그인된 사용자 ID: " + userId);
//            model.addAttribute("isLoggedIn", true);
//        } else {
//            System.out.println("로그인되지 않은 사용자");
//            model.addAttribute("isLoggedIn", false);
//        }
//
//        // 모델에 게시글 목록 추가
//        model.addAttribute("posts", posts);
//
//        // post_list.jsp로 이동
//        return "post/post_list";
//    }
    
    @GetMapping("/api/post/search")
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
