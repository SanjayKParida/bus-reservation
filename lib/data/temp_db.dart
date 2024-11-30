import '../models/bus_model.dart';
import '../models/bus_reservation.dart';
import '../models/bus_schedule.dart';
import '../models/bus_route.dart';
import '../utils/constants.dart';

class TempDB {
  static List<Bus> tableBus = [
    Bus(
        busId: 1,
        busName: 'Volvo',
        busNumber: 'Test-0001',
        busType: busTypeACBusiness,
        totalSeat: 18),
    Bus(
        busId: 2,
        busName: 'BharatBenz',
        busNumber: 'Test-0002',
        busType: busTypeACEconomy,
        totalSeat: 32),
    Bus(
        busId: 3,
        busName: 'Tata',
        busNumber: 'Test-0003',
        busType: busTypeNonAc,
        totalSeat: 40),
  ];

  static List<BusRoute> tableRoute = [
    BusRoute(
        routeId: 1,
        routeName: 'Bhubaneshwar-Berhampur',
        cityFrom: 'Bhubaneshwar',
        cityTo: 'Berhampur',
        distanceInKm: 169),
    BusRoute(
        routeId: 2,
        routeName: 'Cuttack-Kendrapara',
        cityFrom: 'Cuttack',
        cityTo: 'Kendrapara',
        distanceInKm: 60),
    BusRoute(
        routeId: 3,
        routeName: 'Puri-Sambalpur',
        cityFrom: 'Puri',
        cityTo: 'Sambalpur',
        distanceInKm: 340),
    BusRoute(
        routeId: 4,
        routeName: 'Puri-Baripada',
        cityFrom: 'Puri',
        cityTo: 'Baripada',
        distanceInKm: 270),
  ];
  static List<BusSchedule> tableSchedule = [
    BusSchedule(
      scheduleId: 1,
      bus: tableBus[0],
      busRoute: tableRoute[0],
      departureTime: '18:00',
      ticketPrice: 2000,
    ),
    BusSchedule(
      scheduleId: 2,
      bus: tableBus[1],
      busRoute: tableRoute[0],
      departureTime: '20:00',
      ticketPrice: 1600,
    ),
    BusSchedule(
      scheduleId: 3,
      bus: tableBus[2],
      busRoute: tableRoute[0],
      departureTime: '22:00',
      ticketPrice: 1000,
    ),
    BusSchedule(
      scheduleId: 4,
      bus: tableBus[0],
      busRoute: tableRoute[1],
      departureTime: '18:00',
      ticketPrice: 1500,
    ),
    BusSchedule(
      scheduleId: 5,
      bus: tableBus[1],
      busRoute: tableRoute[1],
      departureTime: '18:00',
      ticketPrice: 1000,
    ),
    BusSchedule(
      scheduleId: 6,
      bus: tableBus[2],
      busRoute: tableRoute[1],
      departureTime: '18:00',
      ticketPrice: 500,
    ),
    BusSchedule(
      scheduleId: 7,
      bus: tableBus[0],
      busRoute: tableRoute[2],
      departureTime: '18:00',
      ticketPrice: 4000,
    ),
    BusSchedule(
      scheduleId: 8,
      bus: tableBus[1],
      busRoute: tableRoute[2],
      departureTime: '18:00',
      ticketPrice: 3200,
    ),
    BusSchedule(
      scheduleId: 9,
      bus: tableBus[2],
      busRoute: tableRoute[2],
      departureTime: '18:00',
      ticketPrice: 1700,
    ),
    BusSchedule(
      scheduleId: 10,
      bus: tableBus[0],
      busRoute: tableRoute[3],
      departureTime: '18:00',
      ticketPrice: 3000,
    ),
    BusSchedule(
      scheduleId: 11,
      bus: tableBus[1],
      busRoute: tableRoute[3],
      departureTime: '18:00',
      ticketPrice: 2100,
    ),
    BusSchedule(
      scheduleId: 12,
      bus: tableBus[2],
      busRoute: tableRoute[3],
      departureTime: '18:00',
      ticketPrice: 1450,
    ),
  ];
  static List<BusReservation> tableReservation = [];
}
