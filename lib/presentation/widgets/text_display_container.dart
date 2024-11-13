// Separate Widget for Text Container Display
import 'package:flutter/material.dart';

class TextDisplayContainer extends StatelessWidget {
  const TextDisplayContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]!),
          borderRadius: BorderRadius.circular(16),
        ),
        child: child,
      ),
    );
  }
}
