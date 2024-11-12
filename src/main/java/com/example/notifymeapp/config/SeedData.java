package com.example.notifymeapp.config;

import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.entity.User;
import com.example.notifymeapp.service.RoleService;
import com.example.notifymeapp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Component
@RequiredArgsConstructor
public class SeedData implements CommandLineRunner {
     private final RoleService roleService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        List<Role> roles=roleService.getAllRoles();

        if (roles.isEmpty()) {
            Role user = new Role();
            user.setName("USER");
            roleService.saveRole(user);

            Role admin = new Role();
            admin.setName("ADMIN");
            roleService.saveRole(admin);
        }

        List<User> users = userService.getUsers();

        if (users.isEmpty()) {
            User user = new User();
            user.setFullName("Admin");
            user.setEmail("admin@admin.com");
            user.setPassword(passwordEncoder.encode("Qq!!"));
            user.setEnabled(true);
            // Fetch roles from the database
            Set<Role> roles1 = new HashSet<>();
            Role role = roleService.getRoleById("ADMIN");
            roles1.add(role);
            user.setRoles(roles1);
            userService.saveUser(userService.convertToDto(user));
        }
    }
}
