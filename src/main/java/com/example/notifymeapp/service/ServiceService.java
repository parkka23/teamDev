package com.example.notifymeapp.service;

import com.example.notifymeapp.dto.ServiceDto;
import com.example.notifymeapp.entity.Chat;
import com.example.notifymeapp.entity.Email;
import com.example.notifymeapp.entity.ServiceEntity;
import com.example.notifymeapp.repository.ServiceRepository;
import com.vdurmont.emoji.EmojiParser;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ServiceService {
    private final ServiceRepository serviceRepository;
    private final ChatService chatService;
    private final EmailService emailService;
//    private final EmailSenderService emailSenderService;


    public List<ServiceEntity> getServices() {
        return (List<ServiceEntity>) serviceRepository.findAll();
    }
    public Optional<ServiceDto> getServiceDtoById(Long id) {
        Optional<ServiceEntity> serviceOptional = serviceRepository.findById(id);
        if (serviceOptional.isPresent()) {
            ServiceEntity serviceEntity = serviceOptional.get();
            return Optional.of(convertToDto(serviceEntity));
        } else {
            return Optional.empty();
        }
    }

public ServiceEntity getServiceById(Long id) {
    return serviceRepository.findById(id).orElseThrow(() -> new NoSuchElementException("ServiceEntity not found with id: " + id));
}

    public Optional<ServiceEntity> getService(Long id){
        return Optional.of(serviceRepository.findById(id).get());
    }

public ServiceEntity saveService(ServiceDto serviceDto) {
    ServiceEntity serviceEntity = convertToEntity(serviceDto);
    trimServiceFields(serviceEntity);
    return serviceRepository.save(serviceEntity);
}

    public ServiceEntity updateService(ServiceEntity service) {
        trimServiceFields(service);
        ServiceEntity existing = getServiceById(service.getId());
        if(existing == null){
            throw new NoSuchElementException("Service with name " + service.getName() + " not found.");
        }

        service.setChats(existing.getChats());
        service.setEmails(existing.getEmails());
        return serviceRepository.save(service);
    }

    private void trimServiceFields(ServiceEntity service) {
        if (service.getName() != null) {
            service.setName(service.getName().trim());
        }
        if (service.getDescription() != null) {
            service.setDescription(service.getDescription().trim());
        }
    }
    public void deleteService(Long id) {
        serviceRepository.deleteById(id);
    }

    public ServiceDto convertToDto(ServiceEntity service) {
        if (service == null) {
            return null;
        }

        Set<Long> chatIds = new HashSet<>();
        if (service.getChats() != null) {
            chatIds = service.getChats().stream()
                    .map(Chat::getChatId)
                    .collect(Collectors.toSet());
        }

        Set<String> emailAddresses = new HashSet<>();
        if (service.getEmails() != null) {
            emailAddresses = service.getEmails().stream()
                    .map(Email::getEmail)
                    .collect(Collectors.toSet());
        }

        return ServiceDto.builder()
                .id(service.getId())
                .name(service.getName())
                .chats(chatIds)
                .emails(emailAddresses)
                .sendTo(service.getSendTo())
                .description(service.getDescription())
                .build();
    }


    private ServiceEntity convertToEntity(ServiceDto serviceDto) {
        Set<Chat> chats = new HashSet<>();
        if (serviceDto.getChats() != null) {
            chats = serviceDto.getChats().stream()
                    .map(chatId -> chatService.getChatById(chatId))
                    .collect(Collectors.toSet());
        }

        Set<Email> emails = new HashSet<>();
        if (serviceDto.getEmails() != null) {
            emails = serviceDto.getEmails().stream()
                    .map(Email::new)
                    .collect(Collectors.toSet());
        }

        return ServiceEntity.builder()
                .id(serviceDto.getId())
                .name(serviceDto.getName())
                .chats(chats)
                .emails(emails)
                .sendTo(serviceDto.getSendTo())
                .description(serviceDto.getDescription())
                .build();
    }

    public void deleteChatFromService(Long serviceId, Long chatId) {
        ServiceEntity serviceEntity = getServiceById(serviceId);
        if (serviceEntity != null) {
            // Remove the chat with the given ID from the service
            serviceEntity.getChats().removeIf(chat -> Objects.equals(chat.getChatId(), chatId));
            // Update the service in the database
            serviceRepository.save(serviceEntity);
        } else {
            throw new NoSuchElementException("Service with ID " + serviceId + " not found.");
        }
    }

    public void deleteEmailFromService(Long serviceId, String emailAddress) {
        ServiceEntity serviceEntity = getServiceById(serviceId);
        if (serviceEntity != null) {
            // Remove the email with the given address from the service
            serviceEntity.getEmails().removeIf(email -> Objects.equals(email.getEmail(), emailAddress));
            // Update the service in the database
            serviceRepository.save(serviceEntity);
        } else {
            throw new NoSuchElementException("Service with ID " + serviceId + " not found.");
        }
    }

    public List<Chat> getChatsNotBelongingToService(Long serviceId) {
        ServiceEntity service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new NoSuchElementException("Service not found with ID: " + serviceId));

        List<Chat> allChats = chatService.getAllChats();
        Set<Long> serviceChatIds = service.getChats().stream().map(Chat::getChatId).collect(Collectors.toSet());

        return allChats.stream()
                .filter(chat -> !serviceChatIds.contains(chat.getChatId()))
                .collect(Collectors.toList());
    }

    public List<Email> getEmailsNotBelongingToService(Long serviceId) {
        ServiceEntity service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new NoSuchElementException("Service not found with ID: " + serviceId));

        List<Email> allEmails = emailService.getAllEmails();
        Set<String> serviceEmails = service.getEmails().stream().map(Email::getEmail).collect(Collectors.toSet());

        return allEmails.stream()
                .filter(email -> !serviceEmails.contains(email.getEmail()))
                .collect(Collectors.toList());
    }


    public void addChatsToService(Long serviceId, List<Long> chatIds) {
        // Retrieve the service by its ID
        ServiceEntity service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new NoSuchElementException("Service not found with ID: " + serviceId));

        // Retrieve the chats corresponding to the chatIds
        List<Chat> chatsToAdd = chatIds.stream()
                .map(chatId -> chatService.getChatById(chatId))
                .filter(Objects::nonNull) // Filter out null chats
                .collect(Collectors.toList()); // Collect to List

        // Add the retrieved chats to the service
        service.getChats().addAll(chatsToAdd);

        // Save the updated service
        serviceRepository.save(service);
    }


    public void addEmailsToService(Long serviceId, List<String> emails) {
        // Retrieve the service by its ID
        ServiceEntity service = serviceRepository.findById(serviceId)
                .orElseThrow(() -> new NoSuchElementException("Service not found with ID: " + serviceId));

        // Retrieve the chats corresponding to the chatIds
        List<Email> emailsToAdd = emails.stream()
                .map(email -> emailService.getEmailById(email))
                .filter(Objects::nonNull) // Filter out null chats
                .collect(Collectors.toList());

        // Add the retrieved chats to the service
        service.getEmails().addAll(emailsToAdd);

        // Save the updated service
        serviceRepository.save(service);
    }

//    public void sendMessageToServiceChats(Long serviceId, String message, TelegramBot telegramBot) {
//        ServiceEntity serviceEntity = getServiceById(serviceId);
//        message=EmojiParser.parseToUnicode(":bell: Notification regarding "+serviceEntity.getName() +" service :bell:"+'\n'+message);
//        if (serviceEntity != null) {
//            Set<Chat> chats = serviceEntity.getChats();
//            List<Long> chatIds = chats.stream().map(Chat::getChatId).collect(Collectors.toList());
//            telegramBot.sendMessageToChats(message, chatIds);
//        } else {
//            throw new NoSuchElementException("Service with ID " + serviceId + " not found.");
//        }
//    }
//    public void sendMessageToServiceChats(Long serviceId, String header, String message, TelegramBot telegramBot) {
//        ServiceEntity serviceEntity = getServiceById(serviceId);
//        message=EmojiParser.parseToUnicode(":rotating_light: "+header +" :rotating_light:"+'\n'+message);
//        if (serviceEntity != null) {
//            Set<Chat> chats = serviceEntity.getChats();
//            List<Long> chatIds = chats.stream().map(Chat::getChatId).collect(Collectors.toList());
//            telegramBot.sendMessageToChats(message, chatIds);
//        } else {
//            throw new NoSuchElementException("Service with ID " + serviceId + " not found.");
//        }
//    }

//    public void sendMessageToServiceEmails(Long serviceId, String message) throws IOException {
//        ServiceEntity serviceEntity = getServiceById(serviceId);
//        String subject=EmojiParser.parseToUnicode(":bell: Notification regarding "+serviceEntity.getName()+" service :bell:");
//        if (serviceEntity != null) {
//            Set<Email> emails = serviceEntity.getEmails();
//            List<String> emailAddresses = emails.stream().map(Email::getEmail).collect(Collectors.toList());
//            emailSenderService.sendEmailToMultipleRecipients(emailAddresses, subject, message);
//        } else {
//            throw new NoSuchElementException("Service with ID " + serviceId + " not found.");
//        }
//    }

    public List<ServiceEntity> findServicesByChatId(Long chatId) {
        // Retrieve all services
        List<ServiceEntity> allServices = getServices();

        // Filter services that contain the given chat ID
        return allServices.stream()
                .filter(service -> service.getChats().stream()
                        .anyMatch(chat -> Objects.equals(chat.getChatId(), chatId)))
                .collect(Collectors.toList());
    }


    public List<ServiceEntity> findServicesByEmail(String emailId) {
        // Retrieve all services
        List<ServiceEntity> allServices = getServices();

        // Filter services that contain the given chat ID
        return allServices.stream()
                .filter(service -> service.getEmails().stream()
                        .anyMatch(email -> Objects.equals(email.getEmail(), emailId)))
                .collect(Collectors.toList());
    }

    public List<ServiceEntity> getServices(String sortField, String sortDir) {
        if (sortField == null || sortField.isEmpty()) {
            return serviceRepository.findAll();
        }

        Sort.Direction direction = "asc".equalsIgnoreCase(sortDir) ? Sort.Direction.ASC : Sort.Direction.DESC;
        return serviceRepository.findAll(Sort.by(direction, sortField));
    }

    public List<ServiceEntity> getServices(List<ServiceEntity> services, String sortField, String sortDir) {
        if (sortField == null || sortField.isEmpty() || services.isEmpty()) {
            return services; // Return unsorted list if sortField is empty or services list is empty
        }

        // Determine sorting direction
        Comparator<ServiceEntity> comparator = null;
        if ("name".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(ServiceEntity::getName);
        } else if ("description".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(ServiceEntity::getDescription);
        } else if ("sendTo".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(ServiceEntity::getSendTo);
        }

        if (comparator != null) {
            // Apply sorting direction
            if ("desc".equalsIgnoreCase(sortDir)) {
                comparator = comparator.reversed();
            }
            services.sort(comparator);
        }

        return services;
    }



}
