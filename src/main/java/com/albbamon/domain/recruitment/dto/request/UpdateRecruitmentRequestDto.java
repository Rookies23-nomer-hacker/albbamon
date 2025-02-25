package com.albbamon.domain.recruitment.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UpdateRecruitmentRequestDto {
    Long userId;
    String title;
    String contents;
    Integer wage;
    String dueDate;

    public UpdateRecruitmentRequestDto(String title, String contents, Integer wage, String dueDate) {
        this.title = title;
        this.contents = contents;
        this.wage = wage;
        this.dueDate = dueDate;
    }
}
