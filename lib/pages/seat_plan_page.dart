import 'package:bus_reservation/custom/seat_plan_view.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/providers/appDataProvider.dart';
import 'package:bus_reservation/utils/colors.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatPlanPage extends StatefulWidget {
  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  late BusSchedule schedule;
  late String departureDate;
  int totalSeatBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  bool isFirst = true;
  bool isDataLoading = true;
  ValueNotifier<String> selectedSeatStringNotifier = ValueNotifier('');

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    schedule = argList[0];
    departureDate = argList[1];
    _getData();
    super.didChangeDependencies();
  }

  _getData() async {
    final reservationList =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getReservationsByScheduleAndDepartureDate(
                schedule.scheduleId!, departureDate);
    setState(() {
      isDataLoading = false;
    });
    List<String> seats = [];

    for (final res in reservationList) {
      totalSeatBooked += res.totalSeatBooked;
      seats.add((res.seatNumbers));
    }
    bookedSeatNumbers = seats.join(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Seat Plans",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatBookedColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Booked",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: seatAvailableColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Available",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectedSeatStringNotifier,
                builder: (context, value, _) => Text(
                      "Selected Seats: $value",
                      style: const TextStyle(fontSize: 16),
                    )),
            if (!isDataLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: SeatPlanView(
                    onSeatSelected: (value, seatNo) {
                      if (value) {
                        selectedSeats.add(seatNo);
                      } else {
                        selectedSeats.remove(seatNo);
                      }
                      selectedSeatStringNotifier.value =
                          selectedSeats.join(',');
                    },
                    totalSeatBooked: totalSeatBooked,
                    bookedSeatNumbers: bookedSeatNumbers,
                    totalSeats: schedule.bus.totalSeat,
                    isBusinessClass: schedule.bus.busType == busTypeACBusiness,
                  ),
                ),
              ),
            OutlinedButton(
                onPressed: () {
                  if (selectedSeats.isEmpty) {
                    showMsg(context, "Select your seats first!");
                  } else {
                    Navigator.pushNamed(
                        context, routeNameBookingConfirmationPage, arguments: [
                      departureDate,
                      schedule,
                      selectedSeatStringNotifier.value,
                      selectedSeats.length
                    ]);
                  }
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
