// Separate Widget for Language Selector Button
import 'package:flutter/material.dart';
import 'package:translazy/core/supported_languages.dart';

class LanguageSelectorButton extends StatelessWidget {
  const LanguageSelectorButton({
    required this.languageCode,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final bool isSelected;
  final String languageCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: Colors.grey[600],
        backgroundColor: Colors.grey[300],
      ),
      icon: Text(SupportedLanguages.getFlag(languageCode)),
      label: Text(SupportedLanguages.getLanguage(languageCode)),
    );
  }
}
