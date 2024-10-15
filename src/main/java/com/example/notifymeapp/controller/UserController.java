package com.example.notifymeapp.controller;

import com.example.notifymeapp.dto.UpdatePasswordRequest;
import com.example.notifymeapp.dto.UserDto;
import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.entity.User;
import com.example.notifymeapp.repository.UserRepository;
import com.example.notifymeapp.service.RoleService;
import com.example.notifymeapp.service.UserDetailsServiceImpl;
import com.example.notifymeapp.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserController {
    private final UserService userService;
    private final RoleService roleService;
    private final UserRepository userRepository;
    private final UserDetailsServiceImpl userDetailsService;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String login(Model model, @RequestParam(name = "error", required = false) String error, Authentication authentication) {
        if (error != null) {
            model.addAttribute("loginError", "Invalid email address or password.");
            return "user/login";
        }

        // Check if the user is authenticated
        boolean isLoggedIn = authentication != null && authentication.isAuthenticated()
                && !"anonymousUser".equals(authentication.getPrincipal());

        System.out.println(isLoggedIn);
        return "user/login";

    }


    @GetMapping("/list")
    public String viewUsers(@RequestParam(required = false) String sortField,
                            @RequestParam(required = false) String sortDir,
                            @RequestParam(required = false) String query,
                            @RequestParam(required = false) String clear,
                            Model model,
                            Authentication authentication,
                            HttpServletRequest request) {

        HttpSession session = request.getSession();
        if (!"/user/list".equals(request.getHeader("Referer"))) {
            session.removeAttribute("previousQuery");
        }
        if ("true".equals(clear)) {
            session.removeAttribute("previousQuery");
        }
        String previousQuery = (String) session.getAttribute("previousQuery");

        List<User> users;

        if (query != null && !query.isEmpty()) {
            users = userRepository.findByFullNameContainingIgnoreCase(query);
            // Update the session with the current query
            session.setAttribute("previousQuery", query);
        } else if (previousQuery != null && !previousQuery.isEmpty()) {
            // Use the previous query if the current one is not specified
            users = userRepository.findByFullNameContainingIgnoreCase(previousQuery);
        } else {
            users = userService.getUsers(); // Fetch all services if no query
        }

        users = userService.getUsers(users, sortField, sortDir); // Apply sorting and filtering

        model.addAttribute("users", users);

        List<String> userRoles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        model.addAttribute("userRoles", userRoles);

        model.addAttribute("sortField", sortField != null ? sortField : "");
        model.addAttribute("sortDir", sortDir != null ? sortDir : "asc");
        model.addAttribute("query", query != null ? query : ""); // Pass the query back to the view

        return "user/allUsers";
    }

    @GetMapping("/{id}/delete")
    public String deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return "redirect:/user/list";
    }
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
//        if (SecurityContextHolder.getContext().getAuthentication() == null ||
//                SecurityContextHolder.getContext().getAuthentication().getPrincipal() instanceof String) {
//            return "redirect:/home";
//
//        }
        model.addAttribute("roles", roleService.getAllRoles());
        return "user/register";

    }

    @PostMapping("/register")
    public String register(@ModelAttribute @Valid UserDto userDto, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("roles", roleService.getAllRoles());
            return "user/register";
        }

        try {
            userService.saveUser(userDto);
        } catch (Exception e) {
            model.addAttribute("registrationError", e.getMessage());
            List<Role> roles = roleService.getAllRoles();
            model.addAttribute("roles", roles);
            return "user/register";
        }

        return "redirect:/user/list";
    }
    @GetMapping("/roles")
    public ResponseEntity<List<String>> getUserRoles(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            List<String> userRoles = authentication.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .collect(Collectors.toList());
            return ResponseEntity.ok(userRoles);
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Collections.emptyList());
    }
    @GetMapping("/{id}")
    public String viewUserDetails(@PathVariable Long id, Model model,Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User loggedUser=userRepository.getUserByUsername(userDetails.getUsername());

            if (Objects.equals(loggedUser.getId(), id)) {
                return "redirect:/user/details";
            }

            Optional<User> optionalUser = userService.getUserById2(id);

            if (optionalUser.isPresent()) {
                User user = optionalUser.get();

                Set<String> userRoles = loggedUser.getRoles().stream()
                        .map(Role::getName)
                        .collect(Collectors.toSet());

                model.addAttribute("user", user);
                model.addAttribute("userRoles", userRoles);
            }
            return "user/userDetails2";
        }
        else {
            return "redirect:/user/login";
        }
    }
    @GetMapping("/update/roles/{id}")
    public String updateRolesForm2(@PathVariable Long id, Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            Optional<User> optionalUser = userService.getUserById2(id);

            if (optionalUser.isPresent()) {
                User user = optionalUser.get();

                List<String> roleIdsList = new ArrayList<>(userService.convertToDto(user).getRoleIds());

                model.addAttribute("user", userService.convertToDto(user));
                model.addAttribute("roleIds", roleIdsList);
                model.addAttribute("roles", roleService.getAllRoles());

            }

            return "user/updateRoles2";
        } else {
            return "redirect:/user/"+id;
        }

    }



    @PostMapping("/update/roles/{id}")
    public String updateRoles2(@PathVariable Long id, @ModelAttribute @Valid UserDto userDto, Authentication authentication, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/updateRoles2";
        }
        Optional<User> optionalUser = userService.getUserById2(id);
        User user = optionalUser.get();

        Set<Role> updatedRoles = userDto.getRoleIds().stream()
                .map(roleService::getRoleById)
                .collect(Collectors.toSet());

        if (updatedRoles.equals(user.getRoles())) {
            return "redirect:/user/"+id;
        }

        user.setRoles(updatedRoles);
        userRepository.save(user);

//        // Re-authenticate with the updated roles
//        UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(user.getEmail());
//        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
//                updatedUserDetails,
//                authentication.getCredentials(),
//                updatedUserDetails.getAuthorities()
//        );
//        SecurityContextHolder.getContext().setAuthentication(newAuthentication);

        return "redirect:/user/"+id;
    }

    @GetMapping("/details")
    public String viewUserDetails(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated()) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User user = userRepository.getUserByUsername(userDetails.getUsername());

            Set<String> userRoles = user.getRoles().stream()
                    .map(Role::getName)
                    .collect(Collectors.toSet());

            model.addAttribute("user", user);
            model.addAttribute("userRoles", userRoles);

        } else {
            return "redirect:/user/login";
        }
        return "user/userDetails";
    }

    @GetMapping("/update/fullName")
    public String updateFullNameForm(Model model,  Authentication authentication ) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User user = userRepository.getUserByUsername(userDetails.getUsername());
            model.addAttribute("user", user);

        } else {
            return "redirect:/user/details";
        }
        return "user/updateFullName";
    }

    @PostMapping("/update/fullName")
    public String updateFullName(@ModelAttribute @Valid UserDto userDto, Authentication authentication,BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user/updateFullName";
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userRepository.getUserByUsername(userDetails.getUsername());

        user.setFullName(userDto.getFullName());
        userRepository.save(user);

        return "redirect:/user/details";
    }

    @GetMapping("/update/email")
    public String updateEmailForm(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User user = userRepository.getUserByUsername(userDetails.getUsername());
            model.addAttribute("user", user);
        } else {
            return "redirect:/user/details";
        }
        return "user/updateEmail";
    }

    @PostMapping("/update/email")
    public String updateEmail(@ModelAttribute @Valid UserDto userDto, Authentication authentication, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/updateEmail";
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userRepository.getUserByUsername(userDetails.getUsername());

        if (userDto.getEmail().equals(user.getEmail())) {
            return "redirect:/user/details";
        }
        if (userRepository.getUserByUsername(userDto.getEmail()) != null) {
            model.addAttribute("updateError", "Email already exists.");
            model.addAttribute("user", user); // Add the user object to the model in case of error
            return "user/updateEmail";
        }

        user.setEmail(userDto.getEmail());
        userRepository.save(user);

        // Re-authenticate with the updated roles
        UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(user.getEmail());
        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
                updatedUserDetails,
                authentication.getCredentials(),
                updatedUserDetails.getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(newAuthentication);

        return "redirect:/user/details";
    }

    @GetMapping("/update/roles")
    public String updateRolesForm(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
            User user = userRepository.getUserByUsername(userDetails.getUsername());
            UserDto userDto = userService.convertToDto(user);
            List<String> roleIdsList = new ArrayList<>(userDto.getRoleIds()); // Convert Set to ArrayList
            model.addAttribute("user", userDto);
            model.addAttribute("roleIds", roleIdsList);  // Use roleIdsList in the template
            model.addAttribute("roles", roleService.getAllRoles());
            return "user/updateRoles";
        } else {
            return "redirect:/user/details";
        }

    }

    @PostMapping("/update/roles")
    public String updateRoles(@ModelAttribute @Valid UserDto userDto, Authentication authentication, BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "user/updateRoles";
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userRepository.getUserByUsername(userDetails.getUsername());

        Set<Role> updatedRoles = userDto.getRoleIds().stream()
                .map(roleService::getRoleById)
                .collect(Collectors.toSet());

        if (updatedRoles.equals(user.getRoles())) {
            return "redirect:/user/details";
        }

        user.setRoles(updatedRoles);
        userRepository.save(user);

        // Re-authenticate with the updated roles
        UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(user.getEmail());
        Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
                updatedUserDetails,
                authentication.getCredentials(),
                updatedUserDetails.getAuthorities()
        );
        SecurityContextHolder.getContext().setAuthentication(newAuthentication);

        return "redirect:/user/details";
    }

    @GetMapping("/update/password")
    public String updatePasswordForm(Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && authentication.getPrincipal() instanceof UserDetails) {

//            model.addAttribute("user", new UserDto());
            return "user/updatePassword";
        }
        else {
            return "redirect:/user/details";
        }
    }

    @PostMapping("/update/password")
    public String updatePassword(@ModelAttribute @Valid UpdatePasswordRequest request, BindingResult bindingResult, Model model, Authentication authentication) {
        if (bindingResult.hasErrors()) {
            return "user/updatePassword";
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userRepository.getUserByUsername(userDetails.getUsername());

        if (!passwordEncoder.matches(request.getOldPassword(), user.getPassword())) {
            model.addAttribute("updateError", "Wrong old password.");
            return "user/updatePassword";
        }
        else {
            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
            userRepository.save(user);

            // Re-authenticate with the updated roles
            UserDetails updatedUserDetails = userDetailsService.loadUserByUsername(user.getEmail());
            Authentication newAuthentication = new UsernamePasswordAuthenticationToken(
                    updatedUserDetails,
                    authentication.getCredentials(),
                    updatedUserDetails.getAuthorities()
            );
            SecurityContextHolder.getContext().setAuthentication(newAuthentication);
        }
        return "redirect:/user/details";
    }

}

