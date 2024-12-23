import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translazy/core/core.dart';
import 'package:translazy/presentation/presentation.dart';
import 'package:translazy/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final appDir = await getApplicationDocumentsDirectory();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: DevicePreview(
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(
            onScreenshot: screenshotAsFiles(appDir),
          ),
        ],
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
