package com.albbamon.domain.resume.dto;

public class Resume_write_DTO {
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
	private String portfolioData;
	private String portfolioName;
	
	
	public String getSchool() {
	 return school;
	}
	public void setSchool(String school) {
        this.school = school;
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
    public String getWorking_period() {
        return working_period;
    }

    public void setWorking_period(String working_period) {
        this.working_period = working_period;
    }
    
    public String getWorking_day() {
        return working_day;
    }

    public void setWorking_day(String working_day) {
        this.working_day = working_day;
    }
    
    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
    
    public String getPortfolioData() {
        return portfolioData;
    }

    public void setPortfolioData(String portfolioData) {
        this.portfolioData =portfolioData;
    }
    
    public String getPortfolioName() {
        return portfolioName;
    }

    public void setPortfolioName(String portfolioName) {
        this.portfolioName =portfolioName;
    }
    
    
	
	
	public String toString() {
	    return "Resume_write_DTO{" +
	            "school='" + school + '\'' +
	            ", status='" + status +'\''+
	            ", personal='" + personal +'\''+
	            ", work_place_region='" + work_place_region +'\''+
	            ", work_place_city='" + work_place_city +'\''+
	            ", industry_occupation='" + industry_occupation +'\''+
	            ", employmentType='" + employmentType +'\''+
	            ", working_period='" + working_period +'\''+
	            ", working_day='" + working_day +'\''+
	            ", introduction='" + introduction +'\''+
	            ", portfolioData='" + portfolioData +'\''+
	            ", portfolioName='" + portfolioName +'\''+
	            '}';
	}
}