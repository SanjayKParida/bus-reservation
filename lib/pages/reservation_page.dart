import 'package:bus_reservation/custom/reservation_item_body_view.dart';
import 'package:bus_reservation/custom/reservation_item_header_view.dart';
import 'package:bus_reservation/custom/search_box.dart';
import 'package:bus_reservation/models/reservation_expansion_item.dart';
import 'package:bus_reservation/providers/app_data_provider.dart';
import 'package:bus_reservation/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isFirst = true;
  List<ReservationExpansionItem> items = [];

  @override
  void didChangeDependencies() {
    if (isFirst) {
      _getData();
    }
    super.didChangeDependencies();
  }

  _getData() async {
    final reservations =
        await Provider.of<AppDataProvider>(context, listen: false)
            .getAllReservations();
    items = Provider.of<AppDataProvider>(context, listen: false)
        .getExpansionItems(reservations);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation List"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBox(onSubmit: (value) {
              _search(value);
            }),
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  items[panelIndex].isExpanded = !isExpanded;
                });
              },
              children: items
                  .map((item) => ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) =>
                          ReservationItemHeaderView(
                              reservationHeader: item.header),
                      body:
                          ReservationItemBodyView(reservationBody: item.body)))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  void _search(String value) async {
    final data = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByMobile(value);
    if (data.isEmpty) {
      showMsg(context, "No records found!!");
    }
    setState(() {
      items = Provider.of<AppDataProvider>(context, listen: false)
          .getExpansionItems(data);
    });
  }
}
