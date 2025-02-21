package com.albbamon.domain.user.entity;

import com.albbamon.domain.user.dto.request.CreateUserRequestDto;
import com.albbamon.domain.post.entity.Post;
import com.albbamon.domain.qna.entity.Qna;
import com.albbamon.global.common.entity.BaseTimeEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder(access = AccessLevel.PRIVATE)
@Getter
@Table(name = "user")
@Entity
public class User extends BaseTimeEntity {
    @Id
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    private String email;

    @NotNull
    private String password;

    @NotNull
    private String name;

    private String phone;

    @Builder.Default
    private Integer pwChkNum = 0;

    @Builder.Default
    private Boolean pwCheck = false;

    private String ceoNum;

    private String company;

    private String profileImg;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<Post> postList = new ArrayList<>();

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<Qna> qnaList = new ArrayList<>();

    public static User createUser(CreateUserRequestDto requestDto, String encodedPassword) {
        return User.builder()
                .email(requestDto.email())
                .password(encodedPassword)
                .name(requestDto.name())
                .phone(requestDto.phone())
                .ceoNum(requestDto.ceoNum())
                .company(requestDto.company())
                .build();
    }
}
