package com.example.notifymeapp.controller;

import com.example.notifymeapp.entity.User;
import com.example.notifymeapp.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {
    private final UserRepository userRepository;
    @GetMapping("/home")
    public String home(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && !(authentication.getPrincipal() instanceof String)) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User user = userRepository.getUserByUsername(userDetails.getUsername());
            model.addAttribute("username", user.getFullName());
        }
        return "home";
    }


}
