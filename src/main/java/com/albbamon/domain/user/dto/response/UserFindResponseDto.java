package com.albbamon.domain.user.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter//
public class UserFindResponseDto {
    private String email;
    private String type;
    private boolean success;
}