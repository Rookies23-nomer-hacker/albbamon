package com.albbamon.domain.recruitment.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateRecruitmentRequestDto {
    Long userId;
    String title;
    String contents;
    Integer wage;
    String dueDate;

    public CreateRecruitmentRequestDto(String title, String contents, Integer wage, String dueDate) {
        this.title = title;
        this.contents = contents;
        this.wage = wage;
        this.dueDate = dueDate;
    }
}
