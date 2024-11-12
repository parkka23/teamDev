package com.example.notifymeapp.repository;

import com.example.notifymeapp.entity.Email;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EmailRepository extends JpaRepository<Email, String> {
    List<Email> findByEmailContainingIgnoreCase (String email);
//    Page<Email> findByEmailContainingIgnoreCase(String email, Pageable pageable);
    boolean existsById(String email);

}