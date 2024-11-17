import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:translazy/core/localization/generated/l10n.dart';
import 'package:translazy/presentation/history_screen.dart';
import 'package:translazy/presentation/home_screen.dart';
import 'package:translazy/providers/localization_provider.dart';
import 'package:translazy/providers/theme_notifier_provider.dart';

class BaseScreen extends ConsumerStatefulWidget {
  const BaseScreen({super.key});

  @override
  ConsumerState<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends ConsumerState<BaseScreen> {
  int _currentIndex = 0;
  final pages = [
    const HomeScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.appName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => ref.read(themeNotifierProvider.notifier).toggle(),
          icon: Icon(
            ref.watch(themeNotifierProvider)
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
        ),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (value) =>
                ref.read(localizationNotifierProvider.notifier).toggle(value),
            itemBuilder: (context) {
              return S.delegate.supportedLocales.map((locale) {
                return PopupMenuItem<Locale>(
                  value: locale,
                  child: Text(locale.languageCode),
                );
              }).toList();
            },
          ),
          const Gap(8),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.translate),
            title: Text(S.of(context).translation),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.history),
            title: Text(S.of(context).history),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: pages.firstWhere(
            (page) => _currentIndex == pages.indexOf(page),
          ),
        ),
      ),
    );
  }
}
