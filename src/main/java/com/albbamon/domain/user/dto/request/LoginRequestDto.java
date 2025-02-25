package com.albbamon.domain.user.dto.request;

public class LoginRequestDto {
    private String email;
    private String password;
    private String ceoNum;
   // private String userType; // personal or business

    // 기본 생성자
    public LoginRequestDto() {}

    public LoginRequestDto(String email, String password, String ceoNum) {
        this.email = email;
        this.password = password;
        this.ceoNum = ceoNum;
    }
	 

    // Getter 및 Setter
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
	//public String getUserType() { return userType; } public void
	//setUserType(String userType) { this.userType = userType; }
    public String getCeoNum() { return ceoNum; }
    public void setCeoNum(String ceoNum) { this.ceoNum = ceoNum; }
}
