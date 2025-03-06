package com.albbamon.domain.resume.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Builder(access = AccessLevel.PRIVATE)
@Getter
@Setter
public class ResumeListDto {
    private Long resume_id;
    private String school;
    private String status;
    private String personal;
    private String work_place_region;
    private String work_place_city;
    private String industry_occupation;
    private String employmentType;
    private String working_period;
    private String working_day;
    private String introduction;
    private String portfolioname;
    private String portfoliourl;
    private String resume_imgurl;
    private String resume_img_name;
	
}