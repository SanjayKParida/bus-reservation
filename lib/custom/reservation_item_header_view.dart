import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';

class ReservationItemHeaderView extends StatelessWidget {
  final ReservationExpansionHeader reservationHeader;
  const ReservationItemHeaderView({super.key, required this.reservationHeader});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
            "${reservationHeader.departureDate} ${reservationHeader.schedule.departureTime}"),
        subtitle: Column(
          children: [
            Text(
                "${reservationHeader.schedule.busRoute.routeName}-${reservationHeader.schedule.bus.busType}"),
            Text(
                "Booking Time: ${getFormattedDate(DateTime.fromMillisecondsSinceEpoch(reservationHeader.timeStamp), pattern: "EEE MMM dd yyyy HH:mm")}"),
          ],
        ),
      ),
    );
  }
}
