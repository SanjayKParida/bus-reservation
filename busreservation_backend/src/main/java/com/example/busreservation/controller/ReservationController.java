package com.example.busreservation.controller;


import com.example.busreservation.entities.Reservation;
import com.example.busreservation.models.ResponseModel;
import com.example.busreservation.services.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservation")
public class ReservationController {
    @Autowired
    ReservationService reservationService;

    @PostMapping("/add")
    public ResponseModel<Reservation> addReservation(@RequestBody Reservation reservation){
        final Reservation res = reservationService.addReservation(reservation);
        return new ResponseModel<>(HttpStatus.OK.value(), "Reservation Saved", res);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Reservation>> getAllReservations(){
        return ResponseEntity.ok(reservationService.getAllReservations());
    }

    @GetMapping("/query")
    public ResponseEntity<List<Reservation>> getByScheduleAndDepartureDate(@RequestParam Long scheduleId, @RequestParam String departureDate){
        return ResponseEntity.ok(reservationService.getAllReservationsByScheduleAndDepartureDate(scheduleId, departureDate));

    }

    @GetMapping("/all/{mobile}")
    public ResponseEntity<List<Reservation>> getByMobile(@PathVariable(name = "mobile") String mobile){
        return ResponseEntity.ok(reservationService.getReservationsByMobile(mobile));

    }


}
