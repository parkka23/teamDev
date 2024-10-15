package com.example.notifymeapp.dto;

import lombok.*;

import java.util.Set;

@Data
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ServiceDto {
    private Long id;
    private String name;
    private Set<Long> chats;
    private Set<String> emails;
    private String sendTo;
    private String description;

}
