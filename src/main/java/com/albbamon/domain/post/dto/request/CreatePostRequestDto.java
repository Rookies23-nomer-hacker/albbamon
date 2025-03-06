package com.albbamon.domain.post.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreatePostRequestDto {
    private Long userid;
    private String title;
    private String contents;
    private String file;

    public CreatePostRequestDto(String title, String contents) {
        this.title = title;
        this.contents = contents;
        this.file = "file";
    }
}