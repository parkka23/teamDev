package com.example.notifymeapp.service;

import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.repository.RoleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RoleService {
    private final RoleRepository roleRepository;

    public void saveRole(Role role) {
        if (role != null && role.getName() != null) {
            // Check if an email with the same ID already exists
            if (!roleRepository.existsById(role.getName())) {
                // Save the email if it doesn't exist
                roleRepository.save(role);
            }
        } else {
            // Handle the case where email or its ID is null
            throw new IllegalArgumentException("Role or its ID cannot be null");
        }
    }


//    public Role updateEmail(Email email) {
//        boolean existing = emailRepository.existsById(email.getEmail());
//        if(existing){
//            throw new NoSuchElementException("Email " + email.getEmail() + " already exists.");
//        }
//
//        return emailRepository.save(email);
//    }

    public Role getRoleById(String id) {
        return roleRepository.findById(id).get();
    }

    public boolean existsByName(String name) {
        return roleRepository.existsById(name);
    }

//    public void saveEmail(Email email) {
//        if (email != null && email.getEmail() != null) {
//            if (emailRepository.existsById(email.getEmail())) {
//                // If the email with the same ID exists, update it
//                Email existingEmail = emailRepository.getById(email.getEmail());
//                existingEmail.setEmail(email.getEmail()); // Update the email address
//                // You may update other fields here if needed
//                emailRepository.save(existingEmail);
//            } else {
//                // Save the email if it doesn't exist
//                emailRepository.save(email);
//            }
//        } else {
//            // Handle the case where email or its ID is null
//            throw new IllegalArgumentException("Email or its ID cannot be null");
//        }
//    }

    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }
    public void deleteRole(String name) {
        roleRepository.deleteById(name);
    }
}
