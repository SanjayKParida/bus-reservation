import 'package:bus_reservation/data/temp_db.dart';
import 'package:bus_reservation/drawer/main_drawer.dart';
import 'package:bus_reservation/providers/app_data_provider.dart';
import 'package:bus_reservation/utils/constants.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fromCity, toCity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "BusConnect",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      drawer: const MainDrawer(),
      body: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                //FROM CITY DROPDOWN
                const Text(
                  "Select From",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                DropdownButtonFormField<String>(
                    value: fromCity,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.red)),
                    isExpanded: true,
                    hint: const Text(
                      "Departure City",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    items: cities
                        .map((city) =>
                            DropdownMenuItem(value: city, child: Text(city)))
                        .toList(),
                    onChanged: (value) {
                      fromCity = value;
                    }),

                const SizedBox(
                  height: 20,
                ),

                //TO CITY DROPDOWN
                const Text(
                  "Select To",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                DropdownButtonFormField<String>(
                    value: toCity,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return emptyFieldErrMessage;
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        errorStyle: TextStyle(color: Colors.red)),
                    isExpanded: true,
                    hint: const Text("Arrival City"),
                    items: cities
                        .map((city) =>
                            DropdownMenuItem(value: city, child: Text(city)))
                        .toList(),
                    onChanged: (value) {
                      toCity = value;
                    }),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: _showSelectDate,
                          child: const Text(
                            "Select Departure Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      Text(departureDate == null
                          ? "No Date Chosen"
                          : getFormattedDate(departureDate!))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: _search,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      "See Buses",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _showSelectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() {
    if (departureDate == null) {
      showMsg(context, emptyDateErrMessage);
      return;
    }
    if (_formKey.currentState!.validate()) {
      Provider.of<AppDataProvider>(context, listen: false)
          .getRouteByCityFromAndCityTo(fromCity!, toCity!)
          .then((route) {
        Navigator.pushNamed(context, routeNameSearchResultPage,
            arguments: [route, getFormattedDate(departureDate!)]);
      });
    }
  }
}
