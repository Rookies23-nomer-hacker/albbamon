package com.albbamon.domain.recruitment.dto.request;

import lombok.Setter;

@Setter
public class CreateRecruitmentRequestDto {
    private Long userId;
    private String title;
    private String contents;
    private Integer wage;
    private String dueDate;

    public CreateRecruitmentRequestDto(String title, String contents, Integer wage, String dueDate) {
        this.title = title;
        this.contents = contents;
        this.wage = wage;
        this.dueDate = dueDate;
    }
}
