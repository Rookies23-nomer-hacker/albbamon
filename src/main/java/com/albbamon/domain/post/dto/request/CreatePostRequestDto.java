package com.albbamon.domain.post.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor  // 기본 생성자 추가
@AllArgsConstructor // 모든 필드 포함 생성자 추가
public class CreatePostRequestDto {
    private Long userid;
    private String title;
    private String contents;
    private String file;

    // 필요에 따라 이 생성자는 삭제할 수 있습니다.
    public CreatePostRequestDto(String title, String contents) {
        this.title = title;
        this.contents = contents;
        this.file = "file";
    }
}