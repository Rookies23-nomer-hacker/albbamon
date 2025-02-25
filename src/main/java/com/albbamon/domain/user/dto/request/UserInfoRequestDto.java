package com.albbamon.domain.user.dto.request;

public class UserInfoRequestDto {
	private Long userId;

    public UserInfoRequestDto(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }
}
