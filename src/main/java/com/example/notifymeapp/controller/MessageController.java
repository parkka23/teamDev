package com.example.notifymeapp.controller;


import com.example.notifymeapp.entity.Chat;
import com.example.notifymeapp.entity.Email;
import com.example.notifymeapp.service.*;
import com.vdurmont.emoji.EmojiParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/message")
@RequiredArgsConstructor
@Slf4j
public class MessageController {
    private final ServiceService serviceService;
    private final ChatService chatService;
    private final EmailService emailService;
    private final TelegramBot telegramBot;
    private final EmailSenderService emailSenderService;
    private final TransliterationService transliterationService;
    private final KeyboardLayoutConverter keyboardLayoutConverter;

    @GetMapping("/send")
    public String showMessageForm(Model model) {
        List<Chat> chats = chatService.getAllChats();
        List<Email> emails = emailService.getAllEmails();
        model.addAttribute("chats", chats);
        model.addAttribute("emails", emails);
        return "message/sendMessage";
    }

    @PostMapping("/send")
    public String sendMessage(
            @RequestParam(value = "chatIds", required = false) List<Long> chatIds,
            @RequestParam(value = "emails", required = false) List<String> emailAddresses,
            @RequestParam("message") String message,
            Model model) throws IOException {

        String subject = EmojiParser.parseToUnicode(":bell: Notification :bell:");
        if (chatIds != null && !chatIds.isEmpty()) {
            telegramBot.sendMessageToChats(subject + '\n' + message, chatIds);
        }

        if (emailAddresses != null && !emailAddresses.isEmpty()) {
            emailSenderService.sendEmailToMultipleRecipients(emailAddresses, subject, message);
        }

        model.addAttribute("success", true);
        return showMessageForm(model);
    }

//    @GetMapping("/translitRuToEn")
//    @ResponseBody
//    public String transliterateRuToEn(@RequestParam("text") String text) {
//        return transliterationService.translitRuToEn(text);
//    }
//
//    @GetMapping("/translitEnToRu")
//    @ResponseBody
//    public String transliterateEnToRu(@RequestParam("text") String text) {
//        return transliterationService.translitEnToRu(text);
//    }
//
//    @GetMapping("/convertEnToRu")
//    @ResponseBody
//    public String convertEnToRu(@RequestParam("text") String text) {
//        return keyboardLayoutConverter.convertEnToRu(text);
//    }
//
//    @GetMapping("/convertRuToEn")
//    @ResponseBody
//    public String convertRuToEn(@RequestParam("text") String text) {
//        return keyboardLayoutConverter.convertRuToEn(text);
//    }

}
