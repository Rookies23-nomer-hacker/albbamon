package com.albbamon.domain.user.dto.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor  // 기본 생성자 추가d (필수)
@AllArgsConstructor // 
public class UserFindRequestDto {
    private String name;
    private String phone;
    private String ceoNum;
}
