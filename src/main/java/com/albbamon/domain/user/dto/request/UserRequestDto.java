package com.albbamon.domain.user.dto.request;

import lombok.AccessLevel;
import lombok.Builder;

@Builder(access = AccessLevel.PRIVATE)
public record UserRequestDto(
        Long userId
) {
    public static UserRequestDto of(Long userId) {
        return UserRequestDto.builder()
                .userId(userId)
                .build();
    }
}
