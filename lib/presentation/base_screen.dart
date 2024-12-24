import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:translazy/core/core.dart';
import 'package:translazy/presentation/presentation.dart';
import 'package:translazy/providers/providers.dart';

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
        forceMaterialTransparency: true,
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
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(S.of(context).selectLanguage),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: S.delegate.supportedLocales.map((locale) {
                    final isSelected =
                        ref.watch(localizationNotifierProvider) == locale;
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            SupportedLanguages.getLanguage(
                              locale.languageCode,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                          ),
                          const Spacer(),
                          Text(
                            SupportedLanguages.getFlag(locale.languageCode),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      selected: isSelected,
                      onTap: () {
                        ref
                            .read(localizationNotifierProvider.notifier)
                            .toggle(locale);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            icon: const Icon(Icons.language),
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
          padding: const EdgeInsets.all(8),
          child: pages.firstWhere(
            (page) => _currentIndex == pages.indexOf(page),
          ),
        ),
      ),
    );
  }
}
