package com.example.notifymeapp.controller;

import com.example.notifymeapp.dto.ServiceDto;
import com.example.notifymeapp.entity.Chat;
import com.example.notifymeapp.entity.Email;
import com.example.notifymeapp.entity.ServiceEntity;
import com.example.notifymeapp.repository.ServiceRepository;
import com.example.notifymeapp.service.EmailService;
import com.example.notifymeapp.service.ServiceService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.vdurmont.emoji.EmojiParser;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/services")
@RequiredArgsConstructor
@Slf4j
public class ServiceController {
    private final ServiceService serviceService;
    private final ChatService chatService;
    private final EmailService emailService;
    private final TelegramBot telegramBot;
    private final ServiceRepository serviceRepository;

    @GetMapping("/create")
    public String createService(Model model) {
        model.addAttribute("allChats", chatService.getAllChats());
        model.addAttribute("allEmails", emailService.getAllEmails());
        return "services/createService";
    }


    @PostMapping("/create")
    public String createService(@ModelAttribute ServiceDto serviceDTO) {
        serviceService.saveService(serviceDTO);
        return "redirect:/services/all";
    }

//    @GetMapping("/all")
//    public String getAllServices(Model model, Authentication authentication){
//        var services = serviceService.getServices();
//        model.addAttribute("services", services);
//        List<String> userRoles = authentication.getAuthorities().stream()
//                .map(GrantedAuthority::getAuthority)
//                .collect(Collectors.toList());
//
//        model.addAttribute("userRoles", userRoles);
//        return "services/allServices";
//    }

    @GetMapping("/all")
    public String getAllServices(
            @RequestParam(required = false) String sortField,
            @RequestParam(required = false) String sortDir,
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String clear,
            Model model,
            Authentication authentication,
            HttpServletRequest request) {

        // Get the previous query from the session (if any)
        HttpSession session = request.getSession();
        if (!"/services/all".equals(request.getHeader("Referer"))) {
            session.removeAttribute("previousQuery");
        }
        if ("true".equals(clear)) {
            session.removeAttribute("previousQuery");
        }
        String previousQuery = (String) session.getAttribute("previousQuery");

        List<ServiceEntity> services;

        if (query != null && !query.isEmpty()) {
            services = serviceRepository.findByNameContainingIgnoreCase(query);
            // Update the session with the current query
            session.setAttribute("previousQuery", query);
        } else if (previousQuery != null && !previousQuery.isEmpty()) {
            // Use the previous query if the current one is not specified
            services = serviceRepository.findByNameContainingIgnoreCase(previousQuery);
        } else {
            services = serviceService.getServices(); // Fetch all services if no query
        }

        services = serviceService.getServices(services, sortField, sortDir); // Apply sorting and filtering

        model.addAttribute("services", services);

        List<String> userRoles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        model.addAttribute("userRoles", userRoles);

        model.addAttribute("sortField", sortField != null ? sortField : "");
        model.addAttribute("sortDir", sortDir != null ? sortDir : "asc");
        model.addAttribute("query", query != null ? query : ""); // Pass the query back to the view

        return "services/allServices";
    }

    @GetMapping("/{id}")
    public String getServiceById(@PathVariable Long id, Model model,Authentication authentication) {
        ServiceEntity service = serviceService.getServiceById(id);
        model.addAttribute("service", service);

        // Get the user's role from authentication object
        List<String> userRoles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        // Pass the user's role to the template
        model.addAttribute("userRoles", userRoles);
        return "services/getService";
    }

    @GetMapping("/{id}/edit")
    public String updateShowService(@PathVariable Long id, Model model) {
        ServiceEntity service = this.serviceService.getServiceById(id);
        if (service!= null) {
            model.addAttribute("service", service);
        } else {
            new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return "services/updateService";
    }

    @PostMapping("/{id}/edit")
    public String updateService(@PathVariable Long id, @ModelAttribute ServiceEntity service) {
        service.setId(id);
        this.serviceService.updateService(service);
        return "redirect:/services/"+service.getId();
    }

//    @PostMapping("/{id}/edit")
//    public String updateService(@PathVariable Long id, @ModelAttribute ServiceDto serviceDTO) {
//        serviceDTO.setId(id); // Set the ID from the path variable
//        serviceService.saveService(serviceDTO); // Use saveService method with ServiceDto
//        return "redirect:/services/"+id; // Redirect to the service details page
//    }
//
//    @GetMapping("/{id}/edit")
//    public String updateShowService(@PathVariable Long id, Model model) {
//        Optional<ServiceDto> serviceDTOOptional = serviceService.getServiceDtoById(id); // Get ServiceDto by ID
//        if (serviceDTOOptional.isPresent()) {
//            ServiceDto serviceDTO = serviceDTOOptional.get();
//
//
//            // Add the ServiceDto to the model
//            model.addAttribute("service", serviceDTO);
//
//            return "services/updateService"; // Return the updateService template
//        } else {
//            return "redirect:/services/all"; // Redirect to the service list if the service is not found
//        }
//    }

    @GetMapping("/{id}/delete")
    public String deleteService(@PathVariable Long id) {
        serviceService.deleteService(id);
        return "redirect:/services/all";
    }

    @GetMapping("/{id}/add-chat")
    public String showAddChatForm(@PathVariable Long id, Model model) {
        Optional<ServiceDto> serviceDTO = serviceService.getServiceDtoById(id);
        List<Chat> chatsNotBelongingToService = serviceService.getChatsNotBelongingToService(id);

        model.addAttribute("service", serviceDTO.orElse(null));
        model.addAttribute("chats", chatsNotBelongingToService);

        return "services/addChat";
    }


    @GetMapping("/{id}/add-email")
    public String showAddEmailForm(@PathVariable Long id, Model model) {
        Optional<ServiceDto> serviceDTO = serviceService.getServiceDtoById(id);
        List<Email> emailsNotBelongingToService = serviceService.getEmailsNotBelongingToService(id);

        model.addAttribute("service", serviceDTO.orElse(null));
        model.addAttribute("emails", emailsNotBelongingToService);

        return "services/addEmail";
    }

//    @PostMapping("/{id}/add-chat")
//    public String addChatsToService(@PathVariable Long id, @RequestParam(value = "selectedChats", required = false) List<String> selectedChats) {
//        if (selectedChats != null && !selectedChats.isEmpty()) {
//            List<Long> chatIds = selectedChats.stream()
//                    .map(String::trim) // Trim whitespace
//                    .filter(s -> s.matches("-?\\d+")) // Filter out non-numeric strings except "-"
//                    .map(Long::parseLong) // Parse string to Long
//                    .collect(Collectors.toList());
//            serviceService.addChatsToService(id, chatIds);
//        }
//        return "redirect:/services/{id}";
//    }
@PostMapping("/{id}/add-chat")
public String addChatsToService(@PathVariable Long id, @RequestParam(value = "selectedChats", required = false) List<String> selectedChats) {
    if (selectedChats != null && !selectedChats.isEmpty()) {
        List<Long> chatIds=null;
        if(!(selectedChats.size() ==4)) {
            chatIds = selectedChats.stream()
                    .map(String::trim) // Trim whitespace
                    .map(s -> s.replaceAll("[^\\d-]", "")) // Remove non-numeric characters except '-'
                    .filter(s -> s.matches("-?\\d+")) // Filter out strings that don't match the pattern
                    .map(Long::parseLong) // Parse string to Long
                    .collect(Collectors.toList());
        }
        else {
            String combinedChatId = selectedChats.stream()
                    .map(String::trim) // Trim whitespace
                    .collect(Collectors.joining(""));
            Long chatId = Long.parseLong(combinedChatId.replaceAll("[^\\d-]", ""));
            chatIds = new ArrayList<>();
            chatIds.add(chatId);
        }

        System.out.println(chatIds);

        serviceService.addChatsToService(id, chatIds);
    }
    return "redirect:/services/{id}";
}

    @PostMapping("/{id}/add-email")
    public String addEmailsToService(@PathVariable Long id, @RequestParam(value = "selectedEmails", required = false) List<String> selectedEmails) {
        if (selectedEmails != null && !selectedEmails.isEmpty()) {
//            List<Long> chatIds = selectedChats.stream()
//                    .map(String::trim) // Trim whitespace
//                    .map(s -> s.replaceAll("[^\\d-]", "")) // Remove non-numeric characters except '-'
//                    .filter(s -> s.matches("-?\\d+")) // Filter out strings that don't match the pattern
//                    .map(Long::parseLong) // Parse string to Long
//                    .collect(Collectors.toList());
            serviceService.addEmailsToService(id, selectedEmails);
        }
        return "redirect:/services/{id}";
    }

//    @PostMapping("/{id}/delete-chat")
//    public String deleteChatFromService(@PathVariable Long id, @RequestParam("chatId") Long chatId) {
//        serviceService.deleteChatFromService(id, chatId);
//        return "redirect:/services/{id}";
//    }

    @PostMapping("/{id}/delete-chat")
    public String deleteChatFromService(@PathVariable Long id, @RequestParam("chatId") String chatIdStr) {
        try {
            Long chatId = Long.parseLong(chatIdStr.trim().replaceAll("[^\\d-]", ""));
            serviceService.deleteChatFromService(id, chatId);
        } catch (NumberFormatException e) {
            // Handle the error gracefully, maybe log it or inform the user
            System.err.println("Invalid chat ID format: " + chatIdStr);
        }
        return "redirect:/services/{id}";
    }

    @PostMapping("/{id}/delete-email")
    public String deleteEmailFromService(@PathVariable Long id, @RequestParam("email") String email) {
//        try {
//            Long chatId = Long.parseLong(chatIdStr.trim().replaceAll("[^\\d-]", ""));
//            serviceService.deleteChatFromService(id, chatId);
//        } catch (NumberFormatException e) {
//            // Handle the error gracefully, maybe log it or inform the user
//            System.err.println("Invalid chat ID format: " + chatIdStr);
//        }
        serviceService.deleteEmailFromService(id, email);
        return "redirect:/services/{id}";
    }

//@PostMapping("/{id}/add-chat")
//public String addChatsToService(@PathVariable Long id, @RequestParam(value = "selectedChats", required = false) List<Long> selectedChats) {
//    if (selectedChats != null && !selectedChats.isEmpty()) {
//        serviceService.addChatsToService(id, selectedChats); // Pass the selectedChats directly
//    }
//    return "redirect:/services/{id}";
//}


    @PostMapping("/{serviceId}/message-success")
    public String sendMessageSuccess(@RequestParam("serviceId") Long serviceId) throws IOException {
        ServiceEntity service = serviceService.getServiceById(serviceId);
        String message = EmojiParser.parseToUnicode(":white_check_mark: "+service.getName()+" service has successfully completed the task :white_check_mark: ");
//        emailSenderService.sendEmail("park.ksenia23@gmail.com","hello","hello");

        if (service != null) {
            String sendTo = service.getSendTo();
            if (sendTo != null) {
                switch (sendTo) {
                    case "Telegram":
                        // Call method to send message to chats
                        serviceService.sendMessageToServiceChats(serviceId, message,telegramBot);
                        break;
                    case "Email":
                        // Call method to send message to emails
                        serviceService.sendMessageToServiceEmails(serviceId, message);
                        break;
                    case "All":
                        // Call method to send message to both chats and emails
                        serviceService.sendMessageToServiceChats(serviceId, message,telegramBot);
                        serviceService.sendMessageToServiceEmails(serviceId, message);
                        break;
                    default:
                        // Handle if sendTo is neither Telegram nor Email nor All
                        break;
                }
            }
        }

        // Redirect back to service details page
        return "redirect:/services/" + serviceId;
    }
    @PostMapping("/{serviceId}/message-error")
    public String sendMessageError(@RequestParam("serviceId") Long serviceId) throws IOException {
        ServiceEntity service = serviceService.getServiceById(serviceId);
        String message = EmojiParser.parseToUnicode(":warning: ERROR occurred in "+ service.getName()+" service :warning:");
        if (service != null) {
            String sendTo = service.getSendTo();
            if (sendTo != null) {
                switch (sendTo) {
                    case "Telegram":
                        // Call method to send message to chats
                        serviceService.sendMessageToServiceChats(serviceId, message,telegramBot);
                        break;
                    case "Email":
                        // Call method to send message to emails
                        serviceService.sendMessageToServiceEmails(serviceId, message);
                        break;
                    case "All":
                        // Call method to send message to both chats and emails
                        serviceService.sendMessageToServiceChats(serviceId, message,telegramBot);
                        serviceService.sendMessageToServiceEmails(serviceId, message);
                        break;
                    default:
                        // Handle if sendTo is neither Telegram nor Email nor All
                        break;
                }
            }
        }

        // Redirect back to service details page
        return "redirect:/services/" + serviceId;
    }

//    @PostMapping(value = "/send-message", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
//    public ResponseEntity<String> sendMessageToService(@RequestBody Map<String, Object> requestBody) throws IOException {
//        Long serviceId = ((Number) requestBody.get("serviceId")).longValue();
//        String message = (String) requestBody.get("message");
//
//        ServiceEntity service = serviceService.getServiceById(serviceId);
//        if (service == null) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Service not found");
//        }
//
//        String sendTo = service.getSendTo();
//        if (sendTo != null) {
//            switch (sendTo) {
//                case "Telegram":
//                    // Call method to send message to chats
//                    serviceService.sendMessageToServiceChats(serviceId, message, telegramBot);
//                    return ResponseEntity.ok("Message sent to Telegram chats");
//                case "Email":
//                    // Call method to send message to emails
//                    serviceService.sendMessageToServiceEmails(serviceId, message);
//                    return ResponseEntity.ok("Message sent to Email addresses");
//                case "All":
//                    // Call method to send message to both chats and emails
//                    serviceService.sendMessageToServiceChats(serviceId, message, telegramBot);
//                    serviceService.sendMessageToServiceEmails(serviceId, message);
//                    return ResponseEntity.ok("Message sent to Telegram chats and Email addresses");
//                default:
//                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid 'sendTo' value");
//            }
//        } else {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("No 'sendTo' value specified for the service");
//        }
//    }

//@PostMapping(value = "/send-message", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
//public ResponseEntity<String> sendMessageToService(@RequestBody Map<String, Object> requestBody) throws IOException {
//    Long serviceId = ((Number) requestBody.get("serviceId")).longValue();
//    String message = (String) requestBody.get("message");
//    String sendTo = (String) requestBody.get("sendTo");
//
//    ServiceEntity service = serviceService.getServiceById(serviceId);
//    if (service == null) {
//        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Service not found");
//    }
//
//    switch (sendTo) {
//        case "Telegram":
//            // Call method to send message to chats
//            serviceService.sendMessageToServiceChats(serviceId, message, telegramBot);
//            return ResponseEntity.ok("Message sent to Telegram chats");
//        case "Email":
//            // Call method to send message to emails
//            serviceService.sendMessageToServiceEmails(serviceId, message);
//            return ResponseEntity.ok("Message sent to Email addresses");
//        case "All":
//            // Call method to send message to both chats and emails
//            serviceService.sendMessageToServiceChats(serviceId, message, telegramBot);
//            serviceService.sendMessageToServiceEmails(serviceId, message);
//            return ResponseEntity.ok("Message sent to Telegram chats and Email addresses");
//        default:
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid 'sendTo' value");
//    }
//}
@PostMapping(value = "/send-message", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
@PreAuthorize("hasRole('ADMIN')")
public ResponseEntity<String> sendMessageToService(@RequestBody Map<String, Object> requestBody) throws IOException {
    // Log the received JSON payload
    ObjectMapper mapper = new ObjectMapper();
    String requestBodyJson = mapper.writeValueAsString(requestBody);
    System.out.println("MESSAGE: " + requestBodyJson);

    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    boolean isAdmin = authentication.getAuthorities().stream()
            .anyMatch(r -> r.getAuthority().equals("ADMIN"));
    if (!isAdmin) {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("Access denied");
    }

    // Proceed with your existing logic
    Long serviceId = ((Number) requestBody.get("serviceId")).longValue();
    String header = (String) requestBody.get("header");
    String message = (String) requestBody.get("message");
    String sendTo = (String) requestBody.get("sendTo");

    ServiceEntity service;
    try {
        service = serviceService.getServiceById(serviceId);
    } catch (NoSuchElementException e) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Service not found");
    }

    switch (sendTo) {
        case "Telegram":
            // Call method to send message to chats
            serviceService.sendMessageToServiceChats(serviceId, header, message, telegramBot);
            return ResponseEntity.ok("Message sent to Telegram chats");
        case "Email":
            // Call method to send message to emails
            serviceService.sendMessageToServiceEmails(serviceId, message);
            return ResponseEntity.ok("Message sent to Email addresses");
        case "All":
            // Call method to send message to both chats and emails
            serviceService.sendMessageToServiceChats(serviceId, message, telegramBot);
            serviceService.sendMessageToServiceEmails(serviceId, message);
            return ResponseEntity.ok("Message sent to Telegram chats and Email addresses");
        default:
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid 'sendTo' value");
    }
}

}
