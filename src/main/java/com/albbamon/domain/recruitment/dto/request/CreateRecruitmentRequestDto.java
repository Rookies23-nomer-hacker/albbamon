package com.albbamon.domain.recruitment.dto.request;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class CreateRecruitmentRequestDto {
    Long userId;
    String title;
    String contents;
    Integer wage;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    LocalDateTime dueDate;
    
    public CreateRecruitmentRequestDto(String title, String contents, Integer wage, LocalDateTime dueDate) {
        this.title = title;
        this.contents = contents;
        this.wage = wage;
        this.dueDate = dueDate;
    }
}
