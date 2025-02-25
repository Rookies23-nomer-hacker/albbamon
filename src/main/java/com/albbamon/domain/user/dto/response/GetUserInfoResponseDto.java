package com.albbamon.domain.user.dto.response;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public record GetUserInfoResponseDto(
		Long id,
        String name,
        String email,
        String phone,
        String ceoNum,
        String company,
        String profileImg,
        @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss")  // ✅ 날짜 포맷 지정
        LocalDateTime lastModifiedData  // ✅ 추가
) {
}
