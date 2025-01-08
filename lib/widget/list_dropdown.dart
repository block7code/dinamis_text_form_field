import 'package:flutter/material.dart';
import 'package:dinamis_text_form_field/dynamic_text_field.dart';

class DropDown {
  /// This gives the button text or it sets default text as 'click me'.
  final String? buttonText;

  /// This gives the bottom sheet title.
  final String? titleList;

  /// This will give the submit button background color.
  final Color? submitButtonColor;

  /// This will give the hint to the search text filed.
  final String? searchHintText;

  /// This will give the background color to the search text filed.
  final Color? searchBackgroundColor;

  /// This will give the background color to the load list.
  final Color? backgroundColor;

  /// This will give the default search controller to the search text field.
  final TextEditingController searchController;

  /// This will give the list of data.
  final List<SelectedItem> dataList;

  /// This will give the call back to the selected item (single) from list.
  final Function(String)? selectedItem;
  final Function(String)? selectedItem2;
  final Function(Map)? selectedItemMap;

  DropDown({
    Key? key,
    this.buttonText,
    this.titleList,
    this.submitButtonColor,
    this.searchHintText,
    this.searchBackgroundColor,
    this.backgroundColor,
    required this.searchController,
    required this.dataList,
    this.selectedItem,
    this.selectedItem2,
    this.selectedItemMap,
  });
}

class DropDownState {
  DropDown dropDown;
  DropDownState(this.dropDown);

  /// This gives the bottom sheet widget.
  void showModal(context) {
    showModalBottomSheet(
      backgroundColor: dropDown.backgroundColor ?? Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return MainBody(
              dropDown: dropDown,
            );
          },
        );
      },
    );
  }
}

class MainBody extends StatefulWidget {
  final DropDown dropDown;

  const MainBody({required this.dropDown, Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  List<SelectedItem> mainList = [];
  @override
  void initState() {
    super.initState();
    mainList = widget.dropDown.dataList;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.13,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.dropDown.titleList != null
                      ? Text(
                          widget.dropDown.titleList ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : const SizedBox(),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
            _AppTextField(
              dropDown: widget.dropDown,
              onTextChanged: _buildSearchList,
              onClearTap: _onClearTap,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: mainList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ListTile(
                          title: Text(
                            mainList[index].value!,
                          ),
                        ),
                      ),
                      onTap: () {
                        Map<String, Object> selectedData = {};
                        selectedData['key'] = mainList[index].key!;
                        selectedData['value'] = mainList[index].value!;
                        _onUnfocusKeyboardAndPop();
                        setState(() {
                          widget.dropDown.selectedItem
                              ?.call(mainList[index].value!);
                          widget.dropDown.selectedItem2
                              ?.call(mainList[index].value!);
                          widget.dropDown.selectedItemMap?.call(selectedData);
                        });
                      });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _buildSearchList(String userSearchTerm) {
    final results = widget.dropDown.dataList
        .where((element) =>
            element.value!.toLowerCase().contains(userSearchTerm.toLowerCase()))
        .toList();
    if (userSearchTerm.isEmpty) {
      mainList = widget.dropDown.dataList;
    } else {
      mainList = results;
    }
    setState(() {});
  }

  void _onClearTap() {
    widget.dropDown.searchController.clear();
    mainList = widget.dropDown.dataList;
    setState(() {});
  }

  /// This helps to unfocus the keyboard & pop from the bottom sheet.
  _onUnfocusKeyboardAndPop() {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }
}

class _AppTextField extends StatefulWidget {
  final DropDown dropDown;
  final Function(String) onTextChanged;
  final VoidCallback onClearTap;

  const _AppTextField({
    Key? key,
    required this.dropDown,
    required this.onTextChanged,
    required this.onClearTap,
  }) : super(key: key);

  @override
  State<_AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<_AppTextField> {
  @override
  Widget build(BuildContext context) {
    Color colorDefault = Colors.black12;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: widget.dropDown.searchController,
        cursorColor: colorDefault,
        onChanged: (value) {
          widget.onTextChanged(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.dropDown.searchBackgroundColor ?? Colors.black12,
          focusColor: colorDefault,
          contentPadding:
              const EdgeInsets.only(left: 0, bottom: 0, top: 10, right: 15),
          hintText: widget.dropDown.searchHintText ?? 'Search',
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.search,
              color: colorDefault,
            ),
            onPressed: null,
          ),
          suffixIcon: GestureDetector(
            onTap: widget.onClearTap,
            child: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
