package com.example.notifymeapp.repository;
import com.example.notifymeapp.entity.ServiceEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ServiceRepository extends JpaRepository<ServiceEntity, Long> {
    List<ServiceEntity> findByNameContainingIgnoreCase (String name);

}
