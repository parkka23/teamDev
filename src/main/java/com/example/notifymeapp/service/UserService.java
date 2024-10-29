package com.example.notifymeapp.service;

import com.example.notifymeapp.dto.UserDto;
import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.entity.User;
import com.example.notifymeapp.repository.RoleRepository;
import com.example.notifymeapp.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public List<UserDto> getAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }
    public List<User> getUsers() {
        return userRepository.findAll();

    }
    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.getUserByUsername(principal.getName());
    }
    public UserDto getUserById(Long id) {
        var user = userRepository.findById(id).get();
        return convertToDto(user);
    }
    public Optional<User> getUserById2(Long id) {
        return userRepository.findById(id);
    }

    public Optional<User> getUser(Long id) {
        return Optional.of(userRepository.findById(id).get());
    }

@Transactional
public void saveUser(UserDto userDto) {
    if (userRepository.getUserByUsername(userDto.getEmail()) != null) {
        throw new RuntimeException("Email already exists.");
    }
    User user = new User();
    user.setFullName(userDto.getFullName().trim());
    user.setEmail(userDto.getEmail().trim());
    user.setPassword(passwordEncoder.encode(userDto.getPassword()));
    user.setEnabled(true);
    // Fetch roles from the database
    Set<Role> roles = new HashSet<>();
    for (String roleName : userDto.getRoleIds()) {
        Role role = roleRepository.findById(roleName)
                .orElseThrow(() -> new RuntimeException("Role not found: " + roleName));
        roles.add(role);
    }
    user.setRoles(roles);

    userRepository.save(user);
}

    public List<User> getUsers(List<User> users, String sortField, String sortDir) {
        if (sortField == null || sortField.isEmpty() || users.isEmpty()) {
            return users; // Return unsorted list if sortField is empty or services list is empty
        }
        // Determine sorting direction
        Comparator<User> comparator = null;
        if ("fullName".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(User::getFullName);
        } else if ("email".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(User::getEmail);
        }
        if (comparator != null) {
            // Apply sorting direction
            if ("desc".equalsIgnoreCase(sortDir)) {
                comparator = comparator.reversed();
            }
            users.sort(comparator);
        }

        return users;
    }


    @Transactional
    public UserDto updateUser(UserDto userDto) {
        // Fetch the existing user by ID to ensure they exist
        User existingUser = userRepository.findById(userDto.getId())
                .orElseThrow(() -> new NoSuchElementException("User with ID " + userDto.getId() + " not found."));
        if (userDto.getFullName() != null && !userDto.getFullName().isEmpty()) {
            existingUser.setFullName(userDto.getFullName().trim());
        }
        if (userDto.getEmail() != null && !userDto.getEmail().isEmpty()) {
            existingUser.setEmail(userDto.getEmail().trim());
        }
        if (userDto.getPassword() != null && !userDto.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(userDto.getPassword()));
        }

        // Update roles
        Set<Role> roles = new HashSet<>();
        for (String roleName : userDto.getRoleIds()) {
            Role role = roleRepository.findById(roleName)
                    .orElseThrow(() -> new RuntimeException("Role not found: " + roleName));
            roles.add(role);
        }
        // Save the updated user
        userRepository.save(existingUser);

        // Convert the updated user back to a DTO and return it
        return convertToDto(existingUser);
    }
    public void deleteUser(Long id) {
        User user = userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("User not found"));
        // Clear associations
        user.getRoles().clear();
        userRepository.save(user);
        // Now delete the user
        userRepository.delete(user);
    }

    public UserDto convertToDto(User user) {
        return UserDto.builder()
                .id(user.getId())
                .fullName(user.getFullName())
                .email(user.getEmail())
                .password(user.getPassword())
                .roleIds(user.getRoles().stream().map(Role::getName).collect(Collectors.toSet()))
                .enabled(user.isEnabled())
                .build();
    }

    public User convertToEntity(UserDto userDto) {
        User user = User.builder()
                .id(userDto.getId())
                .fullName(userDto.getFullName())
                .email(userDto.getEmail())
                .password(userDto.getPassword())
                .enabled(userDto.isEnabled())
                .build();

        if (userDto.getRoleIds() != null) {
            Set<Role> roles = userDto.getRoleIds().stream()
                    .map(roleId -> Role.builder().name(roleId).build())
                    .collect(Collectors.toSet());
            user.setRoles(roles);
        }
        return user;
    }

}
