import 'package:flutter/material.dart';

enum TextDisplayState {
  idle,
  loading,
  error,
}

class TextDisplayContainer extends StatelessWidget {
  const TextDisplayContainer({
    required this.child,
    this.state = TextDisplayState.idle,
    this.errorMessage,
    super.key,
  });

  final Widget child;
  final TextDisplayState state;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        AnimatedContainer(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.325,
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: _getBorderColor(theme),
              width: state == TextDisplayState.error ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(16),
            color: theme.colorScheme.surface.withValues(alpha: 0.95),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: state == TextDisplayState.loading ? 0.5 : 1.0,
            child: child,
          ),
        ),

        // Loading overlay
        if (state == TextDisplayState.loading)
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Translating...',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

        // Error message
        if (state == TextDisplayState.error && errorMessage != null)
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }

  Color _getBorderColor(ThemeData theme) {
    switch (state) {
      case TextDisplayState.loading:
        return theme.colorScheme.primary;
      case TextDisplayState.error:
        return theme.colorScheme.error;
      case TextDisplayState.idle:
        return theme.colorScheme.outline.withValues(alpha: 0.5);
    }
  }
}
