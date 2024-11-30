package com.example.busreservation.repos;

import com.example.busreservation.entities.Bus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BusRepository extends JpaRepository<Bus, Long> {
}
