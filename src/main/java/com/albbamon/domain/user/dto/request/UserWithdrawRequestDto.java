package com.albbamon.domain.user.dto.request;

public class UserWithdrawRequestDto {
	private Long userId;

    public UserWithdrawRequestDto(Long userId) {
        this.userId = userId;
    }
//
    public Long getUserId() {
        return userId;
    }
}
