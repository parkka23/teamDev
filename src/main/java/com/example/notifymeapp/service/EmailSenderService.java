package com.example.notifymeapp.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmailSenderService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendEmail(String toEmail, String subject, String body) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("park.ksenia23@gmail.com");
            message.setTo(toEmail);
            message.setSubject(subject);
            message.setText(body);

            javaMailSender.send(message);
            System.out.println("Email successfully sent to: " + toEmail);
        } catch (Exception ex) {
            System.err.println("Failed to send email: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

    public void sendEmailToMultipleRecipients(List<String> emailList, String subject, String body) {
        for (String email : emailList) {
            sendEmail(email, subject, body);
        }
    }
}

