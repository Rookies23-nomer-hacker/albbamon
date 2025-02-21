package com.albbamon.domain.payment.entity;

import jakarta.persistence.*;

@Entity
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "pay_id")
    private Long pay_id;

    private String buyerName;
    private String buyerEmail;
    private String buyerTel;
    private String buyerAddr;
    private String buyerPostCode;
    private Long userId;
}