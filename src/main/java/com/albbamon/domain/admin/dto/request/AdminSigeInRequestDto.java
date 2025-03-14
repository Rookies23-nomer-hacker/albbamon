package com.albbamon.domain.admin.dto.request;
import lombok.Data;

@Data
public class AdminSigeInRequestDto {
    private String identity;
    private String password;
    // getters, setters
}