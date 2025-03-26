package com.albbamon;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.nio.file.Files;

@Controller
public class StaticPageController {

    @GetMapping("/play.google.com/store/apps/QRCode")
    public ResponseEntity<byte[]> getMsStoreHtml() throws IOException {
        Resource resource = new ClassPathResource("static/QRCode/MSStore.html");
        byte[] content = Files.readAllBytes(resource.getFile().toPath());

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_TYPE, "text/html; charset=UTF-8");

        return new ResponseEntity<>(content, headers, HttpStatus.OK);
    }
}
