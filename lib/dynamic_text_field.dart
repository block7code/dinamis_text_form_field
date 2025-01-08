import 'package:dinamis_text_form_field/dinamis_text_form_field.dart';
import 'package:flutter/material.dart';

enum FormType { basic, material }

enum FieldType { input, listDropdown, listNewPage }

class SelectedItem {
  String? key;
  String? value;

  SelectedItem({
    this.key,
    required this.value,
  });
}

@immutable
class DynamicTextField extends StatefulWidget {
  final TextEditingController textDynamicController; // Declare as final
  final String title;
  final String? titleList;
  final String? hintSearch;

  final String hint;
  final FieldType? fieldtype;
  final FormType? formType;
  final List<SelectedItem>? listItem;
  final InputDecoration? inputDecoration;
  final Color? backgroundColor;
  final String? Function(String?)? validator;

  const DynamicTextField({
    required this.textDynamicController,
    required this.title,
    this.titleList,
    this.hintSearch,
    required this.hint,
    this.listItem,
    this.fieldtype = FieldType.input,
    this.formType = FormType.basic,
    this.inputDecoration,
    this.backgroundColor,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  DynamicTextFieldState createState() => DynamicTextFieldState();
}

class DynamicTextFieldState extends State<DynamicTextField> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  TextEditingController searchController = TextEditingController();
  void loadTextFieldDropdown() {
    DropDownState(
      DropDown(
        searchHintText: widget.hintSearch ?? 'Search...',
        titleList: widget.titleList,
        searchBackgroundColor: Colors.black12,
        dataList: widget.listItem ?? [],
        selectedItem: (String selected) {
          widget.textDynamicController.text = selected;
        },
        searchController: _searchTextEditingController,
        backgroundColor: widget.backgroundColor,
      ),
    ).showModal(context);
  }

  Future<void> loadListNewPage() async {
    final selectedOption = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListNewPage(
          title: widget.title,
          titleList: widget.titleList,
          options: widget.listItem ?? [],
        ),
      ),
    );

    // Handle the returned value
    if (selectedOption != null) {
      widget.textDynamicController.text = selectedOption;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: widget.textDynamicController,
          onTap: widget.fieldtype != FieldType.input
              ? () {
                  FocusScope.of(context).unfocus();
                  widget.fieldtype == FieldType.listDropdown
                      ? loadTextFieldDropdown()
                      : loadListNewPage();
                }
              : null,
          decoration: widget.inputDecoration ??
              InputDecoration(
                isDense: true,
                hintText: widget.hint,
                border: widget.formType == FormType.basic
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(width: 1.5),
                      )
                    : null,
                focusedBorder: widget.formType == FormType.basic
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(width: 1.5),
                      )
                    : null,
                suffixIcon: widget.fieldtype != FieldType.input
                    ? GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();

                          widget.fieldtype == FieldType.listDropdown
                              ? loadTextFieldDropdown()
                              : loadListNewPage();
                        },
                        child: SizedBox(
                          width: 11,
                          child: Icon(
                            widget.fieldtype == FieldType.listDropdown
                                ? Icons.keyboard_arrow_down_sharp
                                : Icons.keyboard_arrow_right,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : null,
              ),
          validator: widget.validator,
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
