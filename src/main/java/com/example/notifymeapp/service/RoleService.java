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

    public Role getRoleById(String id) {
        return roleRepository.findById(id).get();
    }

    public boolean existsByName(String name) {
        return roleRepository.existsById(name);
    }


    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }
    public void deleteRole(String name) {
        roleRepository.deleteById(name);
    }
}
