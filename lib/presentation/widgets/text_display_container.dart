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
          color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
          boxShadow: const [
            BoxShadow(blurRadius: 8, color: Colors.black26),
          ],
        ),
        child: child,
      ),
    );
  }
}
