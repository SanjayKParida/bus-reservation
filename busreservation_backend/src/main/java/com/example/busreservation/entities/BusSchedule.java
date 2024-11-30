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
    @ManyToOne
    @JoinColumn(name = "bus_id")
    private Bus bus;
    @ManyToOne
    @JoinColumn(name = "bus_route_id")
    private BusRoute busRoute;
    private String departureTime;
    private Integer ticketPrice;
    private Integer discount;
    private Integer processingFee;

}
