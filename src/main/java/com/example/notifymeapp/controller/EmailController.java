package com.example.notifymeapp.controller;

import com.example.notifymeapp.entity.Email;
import com.example.notifymeapp.entity.ServiceEntity;
import com.example.notifymeapp.repository.EmailRepository;
import com.example.notifymeapp.service.EmailService;
import com.example.notifymeapp.service.ServiceService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/emails")
@RequiredArgsConstructor
@Slf4j
public class EmailController {
     private final EmailService emailService;
     private final ServiceService serviceService;
     private final EmailRepository emailRepository;

    @GetMapping("/all")
    public String getAllEmails(
            @RequestParam(required = false) String sortField,
            @RequestParam(required = false) String sortDir,
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String clear,
            Model model,
            Authentication authentication,
            HttpServletRequest request) {


        // Get the previous query from the session (if any)
        HttpSession session = request.getSession();
        if (!"/emails/all".equals(request.getHeader("Referer"))) {
            session.removeAttribute("previousQuery");
        }
        if ("true".equals(clear)) {
            session.removeAttribute("previousQuery");
        }
        String previousQuery = (String) session.getAttribute("previousQuery");

        List<Email> emails;

        if (query != null && !query.isEmpty()) {
            emails = emailRepository.findByEmailContainingIgnoreCase(query);
            // Update the session with the current query
            session.setAttribute("previousQuery", query);
        } else if (previousQuery != null && !previousQuery.isEmpty()) {
            // Use the previous query if the current one is not specified
            emails = emailRepository.findByEmailContainingIgnoreCase(previousQuery);
        } else {
            emails = emailService.getAllEmails(); // Fetch all services if no query
        }

        emails = emailService.getEmails(emails, sortField, sortDir); // Apply sorting and filtering

        model.addAttribute("emails", emails);

        List<String> userRoles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        model.addAttribute("userRoles", userRoles);

        model.addAttribute("sortField", sortField != null ? sortField : "");
        model.addAttribute("sortDir", sortDir != null ? sortDir : "asc");
        model.addAttribute("query", query != null ? query : ""); // Pass the query back to the view

        return "emails/allEmails";
    }

    @GetMapping("/{id}/delete")
    public String deleteEmail(@PathVariable String id, Model model, Authentication authentication,HttpServletRequest request) {
        List<ServiceEntity> services = serviceService.findServicesByEmail(id);

        if (!services.isEmpty()) {
            model.addAttribute("errorMessage", "This email cannot be deleted because it is connected to a service.");
            return getAllEmails(null,null,null,null,model, authentication,request); // reload the chat list with the error message

//            return getAllEmails(0,10,null,null,null,null,model, authentication,request); // reload the chat list with the error message
        }

        emailService.deleteEmail(id);
        return "redirect:/emails/all";
    }


    @GetMapping("/create")
    public String createEmail(Model model) {
        return "emails/createEmail";
    }

    @PostMapping("/create")
    public String createEmail(@ModelAttribute Email email, Model model) {
        email.setEmail(email.getEmail().trim());
        if (emailService.existsByEmail(email.getEmail())) {
            model.addAttribute("error", "Email already exists.");
            return "emails/createEmail"; // Return to the create email page with error message
        } else {
            emailService.saveEmail(email);
            return "redirect:/emails/all";
        }
    }

    @GetMapping("/{id}/edit")
    public String updateShowEmail(@PathVariable String id, Model model) {
        Email email = this.emailService.getEmailById(id);
        if (email!= null) {
            model.addAttribute("email", email);
        } else {
            new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return "emails/updateEmail";
    }

    @PostMapping("/{id}/edit")
    public String updateEmail(@PathVariable String id, @ModelAttribute Email email, Model model) {
        String newEmailId = email.getEmail().trim();
        if (id.equals(newEmailId))
            return "redirect:/emails/all";

        if (emailService.existsByEmail(newEmailId)) {
            model.addAttribute("error", "Email already exists.");
            return "emails/updateEmail";
        } else {
            emailService.updateEmail(id, newEmailId);
            return "redirect:/emails/all";
        }
    }


}
