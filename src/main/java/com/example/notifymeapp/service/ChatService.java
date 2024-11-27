package com.example.notifymeapp.service;

import com.example.notifymeapp.entity.Chat;
import com.example.notifymeapp.repository.ChatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatService {
    private final ChatRepository chatRepository;

//    private final TelegramBot telegramBot;

//    public Chat saveChat(Long chatId, String chatName) {
//        if (!chatRepository.existsById(chatId)) {
//            Chat chat = Chat.builder()
//                    .chatId(chatId)
//                    .chatName(chatName)
//                    .build();
//            chatRepository.save(chat);
//        }
//        return null;
//    }
//public void saveChat(org.telegram.telegrambots.meta.api.objects.Chat chat) {
//    Long chatId = chat.getId(); // Extract the chat ID
//    String chatName = chat.getTitle(); // Extract the chat name
//
//    if (!chatRepository.existsById(chatId)) {
//        com.example.notifymeapp.entity.Chat customChat = com.example.notifymeapp.entity.Chat.builder()
//                .chatId(chatId)
//                .chatName(chatName)
//                .build();
//        chatRepository.save(customChat);
//    }
//}

    public void saveChat(Chat chat) {
        Chat existingChat = chatRepository.findById(chat.getChatId()).orElse(null);
        if (existingChat == null) {
            chatRepository.save(chat);
        } else {
            updateChat(chat);
        }
    }

    public void updateChat(Chat chat) {
        Chat existingChat = chatRepository.findById(chat.getChatId()).orElse(null);
        if (existingChat != null) {
            existingChat.setChatName(chat.getChatName());
            chatRepository.save(existingChat);
        }
    }
    public List<Chat> getAllChats() {
        return chatRepository.findAll();
    }


    public List<Chat> getChats(List<Chat> chats, String sortField, String sortDir) {
        if (sortField == null || sortField.isEmpty() || chats.isEmpty()) {
            return chats; // Return unsorted list if sortField is empty or services list is empty
        }

        // Determine sorting direction
        Comparator<Chat> comparator = null;
        if ("name".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(Chat::getChatName);
        }

        if (comparator != null) {
            // Apply sorting direction
            if ("desc".equalsIgnoreCase(sortDir)) {
                comparator = comparator.reversed();
            }
            chats.sort(comparator);
        }

        return chats;
    }
    public void deleteChat(Long id, TelegramBot telegramBot) {
        chatRepository.deleteById(id);
        telegramBot.leaveChat(id);
    }

    public Chat getChatById(Long id) {
        return chatRepository.findById(id).orElse(null); // Возвращаем null, если запись не найдена

    }


}