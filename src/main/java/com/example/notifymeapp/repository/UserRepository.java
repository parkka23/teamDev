package com.example.notifymeapp.repository;

import com.example.notifymeapp.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query("SELECT u FROM User u WHERE u.email = :email")
    User getUserByUsername(@Param("email") String email);

    List<User> findByFullNameContainingIgnoreCase(String fullName);
}
