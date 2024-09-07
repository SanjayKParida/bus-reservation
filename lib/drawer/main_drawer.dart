import 'package:bus_reservation/utils/constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(height: 200, color: Colors.grey),

          //ADD BUS
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddBusPage);
            },
            leading: const Icon(Icons.bus_alert),
            title: const Text("Add Bus"),
          ),

          //ADD ROUTE
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddBusPage);
            },
            leading: const Icon(Icons.route),
            title: const Text("Add Route"),
          ),

          //ADD SCHEDULE
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameAddSchedulePage);
            },
            leading: const Icon(Icons.schedule),
            title: const Text('Add Schedule'),
          ),

          //VIEW RESERVATIONS
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameReservationPage);
            },
            leading: const Icon(Icons.book_online),
            title: const Text('View Reservations'),
          ),

          const Divider(),

          //ADMIN LOGIN
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, routeNameLoginPage);
            },
            leading: const Icon(Icons.login_outlined),
            title: const Text('Admin Login'),
          ),
        ],
      ),
    );
  }
}
