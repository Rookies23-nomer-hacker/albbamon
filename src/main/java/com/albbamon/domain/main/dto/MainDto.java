package com.albbamon.domain.main.dto;

import java.time.LocalDateTime;

import com.albbamon.domain.main.entity.MainEntity;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class MainDto {

    private Long postId;
    private String title;
    private String contents;
    private String file;
    private LocalDateTime createDate;
    private Long userId; // User ID만 포함

    // 생성자 (DTO로 변환하는 메서드)
    public MainDto(Long postId, String title, String contents, String file, LocalDateTime createDate, Long userId) {
        this.postId = postId;
        this.title = title;
        this.contents = contents;
        this.file = file;
        this.createDate = createDate;
        this.userId = userId;
    }

    // 엔티티 -> DTO 변환 메서드
    public static MainDto fromEntity(MainEntity main) {
        return MainDto.builder()
                .postId(main.getPostId())
                .title(main.getTitle())
                .contents(main.getContents())
                .file(main.getFile())
                .createDate(main.getCreateDate())
                //.userId(main.getUser() != null ? main.getUser().getUserId() : null)
                .build();
    }
}