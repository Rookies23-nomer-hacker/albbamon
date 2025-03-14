package com.albbamon.domain.notice.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UpdateRequestDto {
    private Long noticeId;
    private String title;
    private String contents;

    public UpdateRequestDto(String title, String contents) {
        this.title = title;
        this.contents = contents;
    }
}