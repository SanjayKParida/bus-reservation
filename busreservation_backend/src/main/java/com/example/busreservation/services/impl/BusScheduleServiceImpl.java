package com.example.busreservation.services.impl;

import com.example.busreservation.entities.BusRoute;
import com.example.busreservation.entities.BusSchedule;
import com.example.busreservation.models.ReservationApiException;
import com.example.busreservation.repos.BusRouteRespository;
import com.example.busreservation.services.BusRouteService;
import com.example.busreservation.services.BusScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import com.example.busreservation.repos.BusScheduleRepository;

import java.util.List;

@Service
public class BusScheduleServiceImpl implements BusScheduleService {
    @Autowired
    private BusScheduleRepository busScheduleRepository;

    @Autowired
    private BusRouteRespository busRouteRespository;


    @Override
    public BusSchedule addSchedule(BusSchedule busSchedule) throws ReservationApiException{
        final boolean exists = busScheduleRepository.existsByBusAndBusRouteAndDepartureTime(busSchedule.getBus(), busSchedule.getBusRoute(), busSchedule.getDepartureTime());
        if(exists) {
            throw new ReservationApiException(HttpStatus.CONFLICT, "Duplicate Schedule");
        }else {
            return busScheduleRepository.save(busSchedule);
        }
    }

    @Override
    public List<BusSchedule> getAllBusSchedules() {
        return busScheduleRepository.findAll();
    }

    @Override
    public List<BusSchedule> getSchedulesByRoute(String routeName) {
        final BusRoute busRoute = busRouteRespository.findByRouteName(routeName).orElseThrow(() -> new ReservationApiException(HttpStatus.BAD_REQUEST, "Route not found!"));
        return busScheduleRepository.findByBusRoute(busRoute).orElseThrow(() -> new ReservationApiException(HttpStatus.BAD_REQUEST, "Route not found!"));
    }
}
