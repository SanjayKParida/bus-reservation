import 'package:bus_reservation/models/bus_reservation.dart';
import 'package:bus_reservation/models/bus_schedule.dart';
import 'package:bus_reservation/providers/app_data_provider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer.dart';

class BookingConfirmationPage extends StatefulWidget {
  const BookingConfirmationPage({super.key});

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  late BusSchedule schedule;
  late String departureDate;
  late int totalSeatsBooked;
  late String seatNumbers;
  bool isFirst = true;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (isFirst) {
      final argList = ModalRoute.of(context)!.settings.arguments as List;
      departureDate = argList[0];
      schedule = argList[1];
      seatNumbers = argList[2];
      totalSeatsBooked = argList[3];
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirm Booking",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Provide your information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: "Customer Name",
                        filled: true,
                        prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        filled: true,
                        prefixIcon: Icon(Icons.call)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        filled: true,
                        prefixIcon: Icon(Icons.mail)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Booking Summary",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer Name: ${nameController.text}"),
                        Text("Mobile Number: ${mobileController.text}"),
                        Text("Email Address: ${emailController.text}"),
                        Text("Route: ${schedule.busRoute.routeName}"),
                        Text("Departure Date: $departureDate"),
                        Text("Departure Time: ${schedule.departureTime}"),
                        Text("Ticket Price: $currency${schedule.ticketPrice}"),
                        const Text("Platform Fees: $currency 150"),
                        Text("Seat Numbers: $seatNumbers"),
                        Text("Seat Selected: $totalSeatsBooked"),
                        Text(
                            "Grand Total: $currency${getGrandTotal(totalSeatsBooked, schedule.ticketPrice)}"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: _confirmBooking,
                    child: const Text("Confirm Booking"))
              ],
            ),
          )),
    );
  }

  void _confirmBooking() {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
          customerName: nameController.text,
          mobile: mobileController.text,
          email: emailController.text);
      final reservation = BusReservation(
          customer: customer,
          busSchedule: schedule,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          departureDate: departureDate,
          totalSeatBooked: totalSeatsBooked,
          seatNumbers: seatNumbers,
          reservationStatus: reservationActive,
          totalPrice: getGrandTotal(totalSeatsBooked, schedule.ticketPrice));
      Provider.of<AppDataProvider>(context, listen: false)
          .addReservation(reservation)
          .then((response) {
        if (response.responseStatus == ResponseStatus.SAVED) {
          showMsg(context, response.message);
          Navigator.popUntil(context, ModalRoute.withName(routeNameHome));
        } else {
          showMsg(context, response.message);
        }
      }).catchError((error) {
        showMsg(context, "Reservation couldn't be made.");
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
  }
}
