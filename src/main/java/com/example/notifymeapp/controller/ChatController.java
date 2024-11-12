package com.example.notifymeapp.controller;

import com.example.notifymeapp.entity.Chat;
import com.example.notifymeapp.entity.ServiceEntity;
import com.example.notifymeapp.repository.ChatRepository;
import com.example.notifymeapp.service.ChatService;
import com.example.notifymeapp.service.ServiceService;
//import com.example.notifymeapp.service.TelegramBot;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/chats")
@RequiredArgsConstructor
@Slf4j
public class ChatController {
    private final ChatService chatService;
//     private final TelegramBot telegramBot;
     private final ServiceService serviceService;
     private final ChatRepository chatRepository;



    @GetMapping("/all")
    public String getAllChats(
            @RequestParam(required = false) String sortField,
            @RequestParam(required = false) String sortDir,
            @RequestParam(required = false) String query,
            @RequestParam(required = false) String clear,
            Model model,
            Authentication authentication,
            HttpServletRequest request) {

        HttpSession session = request.getSession();
        if (!"/chats/all".equals(request.getHeader("Referer"))) {
            session.removeAttribute("previousQuery");
        }
        if ("true".equals(clear)) {
            session.removeAttribute("previousQuery");
        }
        String previousQuery = (String) session.getAttribute("previousQuery");

        List<Chat> chats;

        if (query != null && !query.isEmpty()) {
            chats = chatRepository.findByChatNameContainingIgnoreCase(query);
            session.setAttribute("previousQuery", query);
        } else if (previousQuery != null && !previousQuery.isEmpty()) {
            chats = chatRepository.findByChatNameContainingIgnoreCase(previousQuery);
        } else {
            chats = chatService.getAllChats();
        }

        chats = chatService.getChats(chats, sortField, sortDir);

        model.addAttribute("chats", chats);

        List<String> userRoles = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        model.addAttribute("userRoles", userRoles);
        model.addAttribute("sortField", sortField != null ? sortField : "");
        model.addAttribute("sortDir", sortDir != null ? sortDir : "asc");
        model.addAttribute("query", query != null ? query : ""); // Pass the query back to the view

        return "chats/allChats";
    }

    @GetMapping("/{id}/delete")
    public String deleteChat(@PathVariable Long id, Model model, Authentication authentication,HttpServletRequest request) {
        List<ServiceEntity> services = serviceService.findServicesByChatId(id);

        if (!services.isEmpty()) {
            model.addAttribute("errorMessage", "This chat cannot be deleted because it is connected to a service.");
            return getAllChats(null,null,null,null,model, authentication,request); // pass both model and authentication
        }

//        chatService.deleteChat(id, telegramBot);
        return "redirect:/chats/all";
    }



}

