package com.albbamon.domain.recruitment.dto.response;

import com.albbamon.domain.recruitment.vo.RecruitmentVo;

import java.util.List;

public record GetRecruitmentResponseDto(
        List<RecruitmentVo> recruitmentList
) {
}
