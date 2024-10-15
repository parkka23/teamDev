package com.example.notifymeapp.config;

import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class SeedData implements CommandLineRunner {
     private final RoleService roleService;

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



    }
}
