import 'package:flutter/material.dart';
import 'package:dinamis_text_form_field/dynamic_text_field.dart';

class ListNewPage extends StatefulWidget {
  final String title;
  final String? titleList;
  final String? searchHintText;
  final Color? backgroundColor;
  final List<SelectedItem> options;

  const ListNewPage({
    Key? key,
    required this.title,
    required this.options,
    this.titleList,
    this.searchHintText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<ListNewPage> createState() => _ListNewPageState();
}

class _ListNewPageState extends State<ListNewPage> {
  final TextEditingController searchController = TextEditingController();
  List<SelectedItem> mainList = [];

  @override
  void initState() {
    super.initState();
    // Initially, populate mainList with all options
    mainList = widget.options;
  }

  // Function to filter the options based on the search term
  _buildSearchList(String userSearchTerm) {
    List<SelectedItem> results = [];

    // Filter options based on search term
    if (userSearchTerm.isEmpty) {
      results = widget.options;
    } else {
      results = widget.options
          .where((element) => element.value!
              .toLowerCase()
              .contains(userSearchTerm.toLowerCase()))
          .toList();
    }

    // Update the main list and trigger UI update
    setState(() {
      mainList = results; // Update the filtered list
    });
  }

  void _onClearTap() {
    searchController.clear();
    _buildSearchList(''); // Clear search and show all items
  }

  @override
  Widget build(BuildContext context) {
    Color colorDefault = Colors.black12;

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: Text(widget.titleList ?? widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search input field
            TextFormField(
              controller: searchController,
              cursorColor: colorDefault,
              onChanged: _buildSearchList, // Call the search function
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                contentPadding: const EdgeInsets.only(
                    left: 0, bottom: 0, top: 10, right: 15),
                hintText: widget.searchHintText ?? 'Search',
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: colorDefault,
                  ),
                  onPressed: null,
                ),
                suffixIcon: GestureDetector(
                  onTap: _onClearTap,
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: mainList.length, // Use filtered mainList
                itemBuilder: (context, index) {
                  final option = mainList[index];
                  return ListTile(
                    title: Text(option.value!),
                    onTap: () {
                      // Return the selected option back to the previous page
                      Navigator.pop(context, option.value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
