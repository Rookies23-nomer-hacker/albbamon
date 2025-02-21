package com.albbamon.domain.user.dto.request;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor  // 기본 생성자 추가d (필수)
@AllArgsConstructor // 모든 필드를 받는 생성자 추가d (이걸 추가해야 오류 해결됨)

public class ChangePwRequestDto {
	private Long userId;
	private String passwd;
    private String newpasswd;
}
