package com.albbamon.domain.user.dto.request;

public record CreateUserRequestDto(
         String email,
         String password,
         String name,
         String phone,
		/*
		 * String addr, String bday,
		 */
        String company,
        String ceoNum
) {
}

/*
 * package com.albbamon.domain.user.dto.request;
 * 
 * import jakarta.validation.constraints.NotNull;
 * 
 * import java.time.LocalDateTime;
 * 
 * public record CreateUserRequestDto(
 * 
 * @NotNull String email,
 * 
 * @NotNull String password,
 * 
 * @NotNull String name,
 * 
 * @NotNull String phone,
 * 
 * @NotNull String addr,
 * 
 * @NotNull LocalDateTime bday,
 * 
 * String company, String ceoNum ) { }
 */
