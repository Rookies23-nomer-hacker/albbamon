package com.albbamon.domain.resume.entity;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder(access = AccessLevel.PRIVATE)
@Getter
@Setter
@Table(name = "resume")//
@Entity
public class Resume_write {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "resume_id")
	private Long resume_id;
	
	@Column(name = "school")
	private String school;
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "personal")
	private String personal;
	
	@Column(name = "work_place_region")
	private String work_place_region;
	
	@Column(name = "work_place_city")
	private String work_place_city;
	
	@Column(name = "industry_occupation")
	private String industry_occupation;
	
	@Column(name = "employmentType")
	private String employmentType;
	
	@Column(name = "working_period")
	private String working_period;
	
	@Column(name = "working_day")
	private String working_day;
	
	@Column(name = "introduction")
	private String introduction;
	
	@Column(name = "portfolioname")
	private String portfolioName;

	
}