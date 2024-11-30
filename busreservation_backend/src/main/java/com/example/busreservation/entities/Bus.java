package com.example.busreservation.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity(name="bus")
@AllArgsConstructor
@NoArgsConstructor
public class Bus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long busId;
    private String busName;
    private String busType;
    private Integer totalSeats;
    @Column(unique = true)
    private String busNumber;


}
