package com.example.busreservation.entities;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter@Setter@NoArgsConstructor@AllArgsConstructor
public class Reservation {
    private String reservationId;
    private Customer customer;
    private BusSchedule busSchedule;
    private Long timestamp;
    private String departureDate;
    private Integer totalSeatBooked;
    private String seatNumbers;
    private String reservationStatus;
    private Integer totalPrice;
}
