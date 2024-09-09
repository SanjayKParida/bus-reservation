package com.example.busreservation.entities;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "bus_schedule")
@Getter@Setter@NoArgsConstructor@AllArgsConstructor
public class BusSchedule {
    @Id@GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long scheduleId;
    private Bus bus;
    private BusRoute busRoute;
    private String departureTime;
    private Integer ticketPrice;
    private Integer discount;
    private Integer processingFee;

}
