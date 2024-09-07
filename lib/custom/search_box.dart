import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSubmit;
  const SearchBox({super.key, required this.onSubmit});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        keyboardType: TextInputType.phone,
        controller: searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: const Text('Search with Mobile No.'),
          suffixIcon: IconButton(
              onPressed: () {
                if (searchController.text.isEmpty) return;
                widget.onSubmit(searchController.text);
              },
              icon: const Icon(Icons.search)),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
