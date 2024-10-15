package com.example.notifymeapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

@SpringBootApplication
public class NotifyMeAppApplication {
//	@Autowired
//	private JavaMailSender mailSender;

	public static void main(String[] args) {
		SpringApplication.run(NotifyMeAppApplication.class, args);
	}


}
