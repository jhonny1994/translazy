import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:translazy/core/supported_languages.dart';
import 'package:translazy/providers/translation_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String sourceLang;
  TextEditingController sourceTextController = TextEditingController();
  late String targetLang;
  TextEditingController translatedTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sourceLang = 'en';
    targetLang = 'ar';
  }

  void showLanguageBottomSheet(
    BuildContext context,
    bool isSourceLang,
  ) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: SupportedLanguages.languages.entries.map(
            (entry) {
              final isLanguageDisabled =
                  (isSourceLang && entry.key == targetLang) ||
                      (!isSourceLang && entry.key == sourceLang);

              return ListTile(
                leading: Text(SupportedLanguages.getFlag(entry.value)),
                title: Text(SupportedLanguages.getLanguage(entry.key)),
                onTap: isLanguageDisabled
                    ? null
                    : () {
                        setState(() {
                          if (isSourceLang) {
                            sourceLang = entry.key;
                          } else {
                            targetLang = entry.key;
                          }
                        });
                        Navigator.pop(context);
                      },
                tileColor: entry.key == (isSourceLang ? sourceLang : targetLang)
                    ? Theme.of(context).colorScheme.secondary
                    : null,
              );
            },
          ).toList(),
        );
      },
    );
  }

  void switchLanguages() {
    setState(() {
      final temp = sourceLang;
      sourceLang = targetLang;
      targetLang = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translationState = ref.watch(translationProvider);
    if (translationState.translation != null &&
        translationState.translation != translatedTextController.text) {
      translatedTextController.text = translationState.translation!;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => translationState.isLoading
                          ? null
                          : showLanguageBottomSheet(context, true),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(SupportedLanguages.getLanguage(sourceLang)),
                    ),
                  ),
                  const Gap(4),
                  IconButton(
                    onPressed: switchLanguages,
                    icon: const Icon(Icons.swap_horiz),
                  ),
                  const Gap(4),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => translationState.isLoading
                          ? null
                          : showLanguageBottomSheet(context, false),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(SupportedLanguages.getLanguage(targetLang)),
                    ),
                  ),
                ],
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: sourceTextController,
                        maxLines: null,
                        expands: true,
                        maxLength: 100,
                        textAlign: TextAlign.center,
                        enabled: !translationState.isLoading,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter text to translate...',
                          counter: SizedBox(),
                        ),
                      ),
                    ),
                    const Gap(8),
                    Flexible(
                      child: TextField(
                        controller: translatedTextController,
                        maxLines: null,
                        expands: true,
                        readOnly: true,
                        onTap: translationState.isLoading ||
                                translationState.error != null ||
                                translationState.translation == null
                            ? null
                            : () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: translatedTextController.text,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Text copied to clipboard!'),
                                  ),
                                );
                              },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Translation will appear here...',
                          errorText: translationState.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              FilledButton(
                onPressed:
                    translationState.isLoading || translationState.error != null
                        ? null
                        : () {
                            if (translationState.translation != null) {
                              sourceTextController.clear();
                              translatedTextController.clear();
                            } else {
                              final textToTranslate = sourceTextController.text;
                              ref.read(translationProvider.notifier).translate(
                                    textToTranslate,
                                    sourceLang,
                                    targetLang,
                                  );
                            }
                          },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  translationState.translation != null ? 'Clear' : 'Translate',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
