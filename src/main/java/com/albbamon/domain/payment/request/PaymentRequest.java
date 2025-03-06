package com.albbamon.domain.payment.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaymentRequest {
    private String buyerName;
    private String buyerEmail;
    private String buyerTel;
    private String buyerAddr;
    private String buyerPostcode;
    private Long userId;

    public PaymentRequest() {}

    public PaymentRequest(String buyerName, String buyerEmail, String buyerTel, 
                          String buyerAddr, String buyerPostcode, Long userId) {
        this.buyerName = buyerName;
        this.buyerEmail = buyerEmail;
        this.buyerTel = buyerTel;
        this.buyerAddr = buyerAddr;
        this.buyerPostcode = buyerPostcode;
        this.userId = userId;
    }
}