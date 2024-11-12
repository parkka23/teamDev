package com.example.notifymeapp.entity;


import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import java.util.HashSet;
import java.util.Set;

@Getter
@Setter
@Builder
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@NoArgsConstructor
@Entity
public class Chat {
    @Id
    private Long chatId;
    private String chatName;
    @ManyToMany(mappedBy = "chats")
    private Set<ServiceEntity> serviceEntities = new HashSet<>();
}