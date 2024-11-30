package com.example.busreservation.services.impl;

import com.example.busreservation.entities.BusRoute;
import com.example.busreservation.models.ReservationApiException;
import com.example.busreservation.repos.BusRepository;
import com.example.busreservation.repos.BusRouteRespository;
import com.example.busreservation.services.BusRouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BusRouteServiceImpl implements BusRouteService {
    @Autowired
    private BusRouteRespository busRouteRespository;

    @Override
    public BusRoute addRoute(BusRoute busRoute) {
        return busRouteRespository.save(busRoute);
    }

    @Override
    public List<BusRoute> getAllBusRoutes() {
        return busRouteRespository.findAll();
    }

    @Override
    public BusRoute getRouteByRouteName(String routeName) {
        return busRouteRespository.findByRouteName(routeName).orElseThrow(() -> new ReservationApiException(HttpStatus.BAD_REQUEST, "No such routes found!"));
    }

    @Override
    public BusRoute getRouteByCityFromAndCityTo(String cityFrom, String cityTo) {
        return busRouteRespository.findByCityFromAndCityTo(cityFrom, cityTo).orElseThrow(() -> new ReservationApiException(HttpStatus.BAD_REQUEST, "No such routes found!"));
    }
}
