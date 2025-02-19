package com.albbamon.domain.recruitment.dto.request;

public record CreateRecruitmentRequestDto(
        String title,
        String contents,
        String dueDate
) {
}
