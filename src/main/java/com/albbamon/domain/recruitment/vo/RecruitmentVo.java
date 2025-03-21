package com.albbamon.domain.recruitment.vo;

import lombok.Builder;

import java.time.LocalDateTime;

@Builder
public record RecruitmentVo(
        Long id,
        String title,
        String dueDate,
        String contents,
        Integer wage,
        String userName
) {
}
