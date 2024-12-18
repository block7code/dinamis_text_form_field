library dinamis_text_form_field;

import 'package:flutter/material.dart';

class DinamisForm extends StatefulWidget {
  final Widget child;
  const DinamisForm({super.key, required this.child});

  @override
  State<DinamisForm> createState() => _DinamisFormState();
}

class _DinamisFormState extends State<DinamisForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 7,
                offset: const Offset(1, 3))
          ]),
      child: widget.child,
    );
  }
}
