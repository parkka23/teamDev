package com.example.notifymeapp.repository;

import com.example.notifymeapp.entity.Chat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ChatRepository extends JpaRepository<Chat, Long> {
    List<Chat> findByChatNameContainingIgnoreCase (String name);
}