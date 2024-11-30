import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';

class ReservationItemBodyView extends StatelessWidget {
  final ReservationExpansionBody reservationBody;
  const ReservationItemBodyView({super.key, required this.reservationBody});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Customer Name: ${reservationBody.customer.customerName}'),
          Text('Mobile No.: ${reservationBody.customer.mobile}'),
          Text('Email: ${reservationBody.customer.email}'),
          Text('Total Seats: ${reservationBody.totalSeatsBooked}'),
          Text('Seat Numbers: ${reservationBody.seatNumbers}'),
          Text('Total Price: $currency ${reservationBody.totalPrice}'),
        ],
      ),
    );
  }
}
