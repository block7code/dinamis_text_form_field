import 'package:dinamis_text_form_field/dinamis_text_form_field.dart';
import 'package:flutter/material.dart';

enum FormType { basic, material }

enum FieldType { input, listDropdown, listNewPage, password }

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
  final TextEditingController textDynamicController;
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
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;

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
    this.onChanged,
    this.onSaved,
    this.autovalidateMode,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  DynamicTextFieldState createState() => DynamicTextFieldState();
}

class DynamicTextFieldState extends State<DynamicTextField> {
  bool isShowPassword = true;
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  // Simplified function to load dropdown
  void loadTextFieldDropdown() {
    DropDownState(
      DropDown(
        searchHintText: widget.hintSearch ?? 'Search...',
        titleList: widget.titleList,
        searchController: _searchTextEditingController,
        dataList: widget.listItem ?? [],
        selectedItem: (selected) {
          widget.textDynamicController.text = selected;
        },
        backgroundColor: widget.backgroundColor,
      ),
    ).showModal(context);
  }

  // Simplified function to load new page
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

    if (selectedOption != null) {
      widget.textDynamicController.text = selectedOption;
    }
  }

  // Common function to handle tap actions
  void _handleTap() {
    if (widget.fieldtype == FieldType.input ||
        widget.fieldtype == FieldType.password) return;

    FocusScope.of(context).unfocus();
    widget.fieldtype == FieldType.listDropdown
        ? loadTextFieldDropdown()
        : loadListNewPage();
  }

  // Function to build InputDecoration
  InputDecoration _buildInputDecoration() {
    return widget.inputDecoration ??
        InputDecoration(
          isDense: true,
          hintText: widget.hint,
          border: _getBorder(),
          focusedBorder: _getFocusedBorder(),
          suffixIcon: _buildSuffixIcon(),
        );
  }

  // Border style for InputDecoration
  OutlineInputBorder? _getBorder() {
    return widget.formType == FormType.basic
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(width: 1.5),
          )
        : null;
  }

  // Focused border style for InputDecoration
  OutlineInputBorder? _getFocusedBorder() {
    return widget.formType == FormType.basic
        ? const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(width: 1.5),
          )
        : null;
  }

  // Function to build suffix icon based on field type
  Widget? _buildSuffixIcon() {
    if (widget.fieldtype == FieldType.input) return null;

    return GestureDetector(
      onTap: _handleSuffixIconTap,
      child: SizedBox(
        width: 11,
        child: _getSuffixIcon(),
      ),
    );
  }

  // Handle tap on suffix icon
  void _handleSuffixIconTap() {
    FocusScope.of(context).unfocus();
    if (widget.fieldtype == FieldType.password) {
      setState(() {
        isShowPassword = !isShowPassword;
      });
    } else if (widget.fieldtype == FieldType.listDropdown) {
      loadTextFieldDropdown();
    } else {
      loadListNewPage();
    }
  }

  // Return appropriate icon based on field type
  Icon _getSuffixIcon() {
    switch (widget.fieldtype) {
      case FieldType.password:
        return Icon(
          isShowPassword ? Icons.visibility : Icons.visibility_off,
          size: 30,
          color: Colors.grey,
        );
      case FieldType.listDropdown:
        return const Icon(
          Icons.keyboard_arrow_down_sharp,
          size: 50,
          color: Colors.grey,
        );
      default:
        return const Icon(
          Icons.keyboard_arrow_right,
          size: 50,
          color: Colors.grey,
        );
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
          onTap: _handleTap,
          decoration: _buildInputDecoration(),
          validator: widget.validator,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          autovalidateMode: widget.autovalidateMode,
          obscureText:
              widget.fieldtype == FieldType.password ? isShowPassword : false,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
