import 'package:bus_reservation/models/bus_route.dart';
import 'package:bus_reservation/providers/app_data_provider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/bus_schedule.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final BusRoute route = argList[0];
    final String departureDate = argList[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Routes"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Text(
            'Showing Results for ${route.cityFrom} - ${route.cityTo} on $departureDate',
            style: const TextStyle(fontSize: 18),
          ),
          Consumer<AppDataProvider>(
            builder: (context, provider, _) => FutureBuilder<List<BusSchedule>>(
              future: provider.getSchedulesByRouteName(route.routeName),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final scheduleList = snapshot.data!;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: scheduleList
                          .map((schedule) => ScheduleItemView(
                              date: departureDate, schedule: schedule))
                          .toList());
                }
                if (snapshot.hasError) {
                  return const Text("Failed to fetch data");
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ScheduleItemView extends StatelessWidget {
  final BusSchedule schedule;
  final String date;

  const ScheduleItemView(
      {super.key, required this.date, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeNameSeatPlanPage,
            arguments: [schedule, date]);
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                schedule.bus.busName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(schedule.bus.busType),
              trailing: Text(
                '$currency ${schedule.ticketPrice}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "From: ${schedule.busRoute.cityFrom}",
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    "From: ${schedule.busRoute.cityTo}",
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Departure Time: ${schedule.departureTime}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    "Total Seats: ${schedule.bus.totalSeat}",
                    style: const TextStyle(fontSize: 13),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
