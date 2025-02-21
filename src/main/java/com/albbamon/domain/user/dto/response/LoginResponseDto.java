package com.albbamon.domain.user.dto.response;

public class LoginResponseDto {
    private String email;
    private String userType;
    private Long userId;
    private boolean success;
    private String message;

    // 기본 생성자
    public LoginResponseDto() {}

    public LoginResponseDto(String email, String userType, boolean success, String message, Long userId) {
        this.email = email;
        this.userId = userId;
        this.userType = userType;
        this.success = success;
        this.message = message;
    }

    // Getter 및 Setter
    public String getUsername() { return email; }
    public void setUsername(String email) { this.email = email; }
    
    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public String getUserType() { return userType; }
    public void setUserType(String userType) { this.userType = userType; }

    public boolean isSuccess() { return success; }
    public void setSuccess(boolean success) { this.success = success; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
}
