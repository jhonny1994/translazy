import 'package:flutter/material.dart';
import 'package:translazy/core/core.dart';

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
    return IconButton(
      onPressed: onTap,
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            SupportedLanguages.getFlag(languageCode),
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 8),
          Text(
            SupportedLanguages.getLanguage(languageCode),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
          ),
        ],
      ),
    );
  }
}
