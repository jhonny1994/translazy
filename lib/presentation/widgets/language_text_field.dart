// Separate Widget for Text Field
import 'package:flutter/material.dart';

class LanguageTextField extends StatelessWidget {
  const LanguageTextField({
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        readOnly: isReadOnly,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          counter: const SizedBox.shrink(),
        ),
      ),
    );
  }
}
