package com.albbamon.domain.resume.entity;

public class File_data {
	private String portfolioData;
    
    public String getPortfolioData() {
        return portfolioData;
    }

    public void setPortfolioData(String portfolioData) {
        this.portfolioData =portfolioData;
    }
	
	public String toString() {
	    return "Resume_write_DTO{" +
	            "portfolioData='" + portfolioData +'\''+
	            '}';
	}
}