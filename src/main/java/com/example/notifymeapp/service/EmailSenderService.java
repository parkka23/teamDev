package com.example.notifymeapp.service;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class EmailSenderService {
    private static final String SENDGRID_API_KEY = "SG.E_w7Zvc_T-6V6s0o-saEog.JczkibV6F0j8K_WHqUva76JgWrwLs_OgFbo66O-Vpp8";

    public static void sendEmail(String toEmail, String subject, String body) throws IOException {
        Email from = new Email("park.ksenia23@gmail.com");
        Email to = new Email(toEmail);
        Content content = new Content("text/plain", body);
        Mail mail = new Mail(from, subject, to, content);

        SendGrid sg = new SendGrid(SENDGRID_API_KEY);
        Request request = new Request();
        try {
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            Response response = sg.api(request);
            System.out.println(response.getStatusCode());
            System.out.println(response.getBody());
            System.out.println(response.getHeaders());
        } catch (IOException ex) {
            System.err.println("Failed to send email: " + ex.getMessage());
            ex.printStackTrace();
            throw ex;
        }
    }

    public void sendEmailToMultipleRecipients(List<String> emailList, String subject, String body) throws IOException {
        for (String email : emailList) {
            sendEmail(email, subject, body);
        }
    }
}
