package com.albbamon.domain.post.dto.request;

public record CreatePostRequestDto(
		long postid,
        String title,
        String contentes,
        String file
        
) {
}
