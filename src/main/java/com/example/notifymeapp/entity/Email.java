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
public class Email {
    @Id
    private String email;
    @ManyToMany(mappedBy = "emails")
    private Set<ServiceEntity> serviceEntities = new HashSet<>();
    public Email(String email) {
        this.email = email;
    }
}