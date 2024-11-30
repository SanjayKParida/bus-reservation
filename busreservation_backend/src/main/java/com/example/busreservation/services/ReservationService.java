package com.example.busreservation.services;

import com.example.busreservation.entities.Reservation;

import java.util.List;

public interface ReservationService {
    Reservation addReservation(Reservation reservation);

    List<Reservation> getAllReservations();

    List<Reservation> getAllReservationsByScheduleAndDepartureDate(Long scheduleId, String departureDate);


    List<Reservation> getReservationsByMobile(String mobile);
}
