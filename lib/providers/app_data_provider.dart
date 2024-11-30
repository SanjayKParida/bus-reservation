import 'package:bus_reservation/data/data_source.dart';
import 'package:bus_reservation/data/dummy_dataSource.dart';
import 'package:bus_reservation/models/app_user.dart';
import 'package:bus_reservation/models/auth_response_model.dart';
import 'package:bus_reservation/models/bus_route.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';

import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/response_model.dart';

class AppDataProvider extends ChangeNotifier {
  List<Bus> _busList = [];
  List<BusRoute> _routeList = [];
  List<BusReservation> _reservationList = [];
  List<BusSchedule> _scheduleList = [];
  List<BusSchedule> get scheduleList => _scheduleList;
  List<Bus> get busList => _busList;
  List<BusRoute> get routeList => _routeList;
  List<BusReservation> get reservationList => _reservationList;
  final DataSource dataSource = DummyDatasource();

  Future<AuthResponseModel?> login(AppUser user) async {
    final response = await dataSource.login(user);
    if (response == null) return null;
    await saveToken(response.accessToken);
    await saveLoginTime(response.logInTime);
    await saveExpirationDuration(response.expirationDuration);

    return response;
  }

  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    return dataSource.getSchedulesByRouteName(routeName);
  }

  Future<List<BusReservation>> getReservationsByScheduleAndDepartureDate(
      int scheduleId, String departureDate) {
    return dataSource.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  }

  List<ReservationExpansionItem> getExpansionItems(
      List<BusReservation> reservationList) {
    return List.generate(reservationList.length, (index) {
      final reservation = reservationList[index];
      return ReservationExpansionItem(
        header: ReservationExpansionHeader(
            reservationId: reservation.reservationId,
            departureDate: reservation.departureDate,
            schedule: reservation.busSchedule,
            timeStamp: reservation.timestamp,
            reservationStatus: reservation.reservationStatus),
        body: ReservationExpansionBody(
            customer: reservation.customer,
            totalSeatsBooked: reservation.totalSeatBooked,
            seatNumbers: reservation.seatNumbers,
            totalPrice: reservation.totalPrice),
      );
    });
  }

  Future<List<BusReservation>> getReservationsByMobile(String mobile) async {
    return dataSource.getReservationsByMobile(mobile);
  }

  Future<ResponseModel> addRoute(BusRoute busRoute) async {
    return dataSource.addRoute(busRoute);
  }

  void getAllBus() async {
    _busList = await dataSource.getAllBus();
    notifyListeners();
  }

  void getAllBusRoutes() async {
    _routeList = await dataSource.getAllRoutes();
    notifyListeners();
  }

  Future<ResponseModel> addBus(Bus bus) {
    return dataSource.addBus(bus);
  }

  Future<ResponseModel> addSchedule(BusSchedule schedule) {
    return dataSource.addSchedule(schedule);
  }

  Future<List<BusReservation>> getAllReservations() async {
    _reservationList = await dataSource.getAllReservation();
    notifyListeners();
    return _reservationList;
  }

  Future<ResponseModel> addReservation(BusReservation reservation) {
    return dataSource.addReservation(reservation);
  }

  Future<BusRoute?> getRouteByCityFromAndCityTo(
      String cityFrom, String cityTo) {
    return dataSource.getRouteByCityFromAndCityTo(cityFrom, cityTo);
  }
}
