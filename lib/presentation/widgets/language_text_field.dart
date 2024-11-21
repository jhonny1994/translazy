import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageTextField extends StatelessWidget {
  const LanguageTextField({
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;

  static const int _maxCharacters = 100;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        readOnly: isReadOnly,
        maxLength: _maxCharacters,
        onChanged: onChanged,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) =>
            null,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        style: theme.textTheme.bodyLarge,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          filled: true,
          fillColor: isReadOnly
              ? theme.colorScheme.surfaceContainerHighest
              : theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
            ),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
