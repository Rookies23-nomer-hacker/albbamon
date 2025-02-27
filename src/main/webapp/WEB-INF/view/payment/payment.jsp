<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 페이지</title>
    
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- 포트원 SDK 라이브러리 추가 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script src="/js/payment/payment.js"></script>
    <script> var apiBaseUrl = "${apiBaseUrl}"; var base_url = "${contextPath}";</script>

</head>
<body>
    <%@ include file="/WEB-INF/view/common/header.jsp" %>
    <div class="container">
        <h2 class="mt-5 text-center"></h2>
        <div class="row justify-content-center mb-4">
            <div class="col-md-8">
                <div class="card">
                    <!-- 강력한 채용 효과 보장 -->
                    <div class="card-body">
                        <span class="badge bg-warning text-dark rounded-3 mb-3">
                            <img src="https://contents.albamon.kr/monimg/msa/business/images/recruit-manager/point_star.svg" alt="" height="16" width="16" class="me-2">
                            강력한 채용 효과 보장
                        </span>
                        <div>
                            <span class="fw-bold">모바일 + PC</span>
                        </div>
                        <div>
                            <h5 class="card-title fw-bold">파워링크</h5>
                        </div>
                    </div>

                    <!-- 상품 위치 아이콘 -->
                    <div class="d-flex justify-content-center">
                        <img src="https://contents.albamon.kr/monimg/msa/business/images/product/recommend/icon_product_card_1.svg" alt="상품 위치 아이콘" height="66" width="66">
                    </div>

                    <!-- 혜택 리스트 -->
                    <hr>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <i class="bi bi-check-circle me-2"></i>
                            <span class="fw-bold text-warning">모바일+PC</span> 노출
                            <div class="tooltip-wrap d-inline-block" tabindex="-1">
                                <button type="button" class="btn btn-link p-0" data-bs-toggle="tooltip" data-bs-placement="top" title="동시적용">
                                    <i class="bi bi-info-circle" style="font-size: 20px;"></i>
                                </button>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <i class="bi bi-check-circle me-2"></i>
                            모바일에서 게시 공고 강조
                            <div class="tooltip-wrap d-inline-block" tabindex="-1">
                                <button type="button" class="btn btn-link p-0" data-bs-toggle="tooltip" data-bs-placement="top" title="모바일에서 공고를 리스트에서 잘 보이도록 하여 알바생들에게 많이 노출돼요!">
                                    <i class="bi bi-info-circle" style="font-size: 20px;"></i>
                                </button>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <i class="bi bi-check-circle me-2"></i>
                            PC에서 게시 공고 강조
                            <div class="tooltip-wrap d-inline-block" tabindex="-1">
                                <button type="button" class="btn btn-link p-0" data-bs-toggle="tooltip" data-bs-placement="top" title="PC에서 공고를 리스트에서 잘 보이도록 하여 알바생들에게 많이 노출돼요!">
                                    <i class="bi bi-info-circle" style="font-size: 20px;"></i>
                                </button>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <i class="bi bi-check-circle me-2"></i>
                            <span class="fw-bold text-warning">1,500,000원</span>
                            <span class="fw-bold text-primary">평생 제공</span>
                        </li>
                        <li class="list-group-item">
                            <i class="bi bi-check-circle me-2"></i>
                            공고 즉시 적용
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 주어진 HTML을 부트스트랩 스타일로 변환 -->
        <div class="card mt-4">
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
                    <!-- 인기 태그 -->
                    <span class="badge bg-primary rounded-3 p-2">인기</span>
                    <span class="fw-bold">파워 링크</span>
                </div>
                <div class="d-flex justify-content-between">
                    <div class="fw-bold">1,500,000원</div>
                    <button type="button" class="btn btn-primary" id="payment" data-user-id="${sessionScope.userid}">결제하기</button>
                </div>
                <div class="mt-2">
                    <small class="text-muted">환불 불가능합니다.</small>
					<div class="mb-3">
					    <label for="buyer_email" id="buyer_email" class="form-label">구매 시 적용 아이디: ${sessionScope.email}</label>
					</div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/view/common/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tooltip 활성화
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    </script>
</body>
</html>
