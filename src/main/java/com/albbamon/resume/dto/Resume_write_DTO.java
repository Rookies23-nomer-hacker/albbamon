package com.albbamon.resume.dto;

import java.util.List;

public class Resume_write_DTO {
	private String education;
	private String status;
	private String personal;
	private String work_place_region;
	private String work_place_city;
	private String industry_occupation;
	private String employmentType;
	
	
	
	public String getEducation() {
	 return education;
	}
	public void setEducation(String education) {
        this.education = education;
    }
	
	public String getStatus() {
		 return status;
	}
	public void setStatus(String status) {
	     this.status = status;
	}

	public String getPersonal() {
	 return personal;
	}
	public void setPersonal(String personal) {
	 this.personal = personal;
	}
	
	public String getWork_place_region() {
		 return work_place_region;
	}
	public void setWork_place_region(String work_place_region) {
		this.work_place_region = work_place_region;
	}
	
	public String getWork_place_city() {
		 return work_place_city;
	}
	public void setWork_place_city(String work_place_city) {
		this.work_place_city = work_place_city;
	}
	
	public String getIndustry_occupation() {
		 return industry_occupation;
	}
	public void setIndustry_occupation(String industry_occupation) {
		this.industry_occupation = industry_occupation;
	}
	
	public String getEmploymentType() {
        return employmentType;
    }

    public void setEmploymentType(String employmentType) {
        this.employmentType = employmentType;
    }
	
	
	public String toString() {
	    return "Resume_write_DTO{" +
	            "education='" + education + '\'' +
	            ", status='" + status +'\''+
	            ", personal='" + personal +'\''+
	            ", work_place_region='" + work_place_region +'\''+
	            ", work_place_city='" + work_place_city +'\''+
	            ", industry_occupation='" + industry_occupation +'\''+
	            ", employmentType='" + employmentType +'\''+
	            '}';
	}
}