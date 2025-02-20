package com.albbamon.domain.main.entity;

import java.time.LocalDateTime;

import com.albbamon.domain.user.entity.User;
import com.albbamon.global.common.entity.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.*;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder(access = AccessLevel.PRIVATE)
@Getter
@Setter
@Table(name = "post")
@Entity
public class Main extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "POST_ID")
    private Long postId;

    @Column(name = "TITLE", nullable = false)
    private String title;

    @Column(name = "CONTENTS", nullable = false)
    private String contents;

    @Column(name = "FILE")
    private String file;

    @Column(name = "CREATE_DATE", nullable = false)
    private LocalDateTime createDate;
}
