package com.albbamon.domain.post.dto.request;

import org.springframework.web.multipart.MultipartFile;

public record CreatePostRequestDto(
		Long postid,
		Long userid,
        String title,
        String contents,
        MultipartFile file
        
) {


}
