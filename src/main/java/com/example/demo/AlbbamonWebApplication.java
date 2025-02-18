package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.albbamon.apply","com.albbamon.career",
		"com.albbamon.community","com.albbamon.recruitment",
		"com.albbamon.resume","com.albbamon.user"})
public class AlbbamonWebApplication {

	public static void main(String[] args) {
		SpringApplication.run(AlbbamonWebApplication.class, args);
	}

}
