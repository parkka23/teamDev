package com.example.notifymeapp.service;

import com.example.notifymeapp.entity.Email;
import com.example.notifymeapp.repository.EmailRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final EmailRepository emailRepository;

    public void saveEmail(Email email) {
        if (email != null && email.getEmail() != null) {
            if (!emailRepository.existsById(email.getEmail())) {
                emailRepository.save(email);
            }
        } else {
            throw new IllegalArgumentException("Email or its ID cannot be null");
        }
    }


//    public Email updateEmail( Email email) {
//        boolean existing = emailRepository.existsById(email.getEmail());
//        if(existing){
//            throw new NoSuchElementException("Email " + email.getEmail() + " already exists.");
//        }
//        return emailRepository.save(email);
//    }

    @Transactional
    public Email updateEmail(String oldEmailId, String newEmailId) {
        Email existingEmail = emailRepository.findById(oldEmailId)
                .orElseThrow(() -> new NoSuchElementException("Email not found with ID: " + oldEmailId));

        // Check if new email ID already exists
        if (emailRepository.existsById(newEmailId)) {
            throw new IllegalArgumentException("Email " + newEmailId + " already exists.");
        }

        // Create new Email entity with new ID and copy data
        Email newEmail = new Email(newEmailId);
        newEmail.setServiceEntities(existingEmail.getServiceEntities());

        // Save new Email entity
        emailRepository.save(newEmail);

        // Delete old Email entity
        emailRepository.delete(existingEmail);

        return newEmail;
    }

    public Email getEmailById(String id) {
        return emailRepository.findById(id).get();
    }

    public boolean existsByEmail(String email) {
        return emailRepository.existsById(email);
    }

    public List<Email> getAllEmails() {
        return emailRepository.findAll();
    }
//public Page<Email> getAllEmails(int page, int size) {
//    Pageable pageable = PageRequest.of(page, size);
//    return emailRepository.findAll(pageable);
//}

    public void deleteEmail(String email) {
        emailRepository.deleteById(email);
    }

    public List<Email> getEmails(List<Email> emails, String sortField, String sortDir) {
        if (sortField == null || sortField.isEmpty() || emails.isEmpty()) {
            return emails; // Return unsorted list if sortField is empty or services list is empty
        }

        // Determine sorting direction
        Comparator<Email> comparator = null;
        if ("email".equalsIgnoreCase(sortField)) {
            comparator = Comparator.comparing(Email::getEmail);
        }

        if (comparator != null) {
            // Apply sorting direction
            if ("desc".equalsIgnoreCase(sortDir)) {
                comparator = comparator.reversed();
            }
            emails.sort(comparator);
        }

        return emails;
    }

//public Page<Email> getEmails(String query, String sortField, String sortDir, int page, int size) {
//    // Create a Pageable object for pagination and sorting
//    Pageable pageable = PageRequest.of(page, size,
//            sortDir.equalsIgnoreCase("asc") ? Sort.by(sortField).ascending() : Sort.by(sortField).descending());
//
//    Page<Email> emailsPage;
//
//    if (query != null && !query.isEmpty()) {
//        // Perform a filtered search with pagination
//        emailsPage = emailRepository.findByEmailContainingIgnoreCase(query, pageable);
//    } else {
//        // Fetch all emails with pagination and sorting
//        emailsPage = emailRepository.findAll(pageable);
//    }
//
//    return emailsPage;
//}


}