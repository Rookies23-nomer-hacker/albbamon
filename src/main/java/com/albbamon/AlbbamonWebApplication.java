package com.albbamon;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

import com.albbamon.config.ApiProperties;

@SpringBootApplication
@EnableConfigurationProperties(ApiProperties.class)
public class AlbbamonWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(AlbbamonWebApplication.class, args);
	}

}
