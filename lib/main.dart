import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translazy/core/localization/generated/l10n.dart';
import 'package:translazy/core/theme.dart';
import 'package:translazy/presentation/base_screen.dart';
import 'package:translazy/presentation/onboarding_screen.dart';
import 'package:translazy/providers/localization_provider.dart';
import 'package:translazy/providers/onboarding_provider.dart';
import 'package:translazy/providers/shared_prefrences_provider.dart';
import 'package:translazy/providers/theme_notifier_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: DevicePreview(
        enabled: Platform.isWindows,
        builder: (context) => const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeNotifierProvider);
    final hasCompletedOnboarding = ref.watch(onboardingProvider);

    return MaterialApp(
      onGenerateTitle: (context) => S.of(context).appName,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: ref.watch(localizationNotifierProvider),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: hasCompletedOnboarding
          ? const BaseScreen()
          : const OnboardingScreen(),
    );
  }
}
