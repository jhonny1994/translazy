import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:translazy/core/supported_languages.dart';
import 'package:translazy/presentation/widgets/custom_icon_button.dart';
import 'package:translazy/presentation/widgets/language_selector_button.dart';
import 'package:translazy/presentation/widgets/language_text_field.dart';
import 'package:translazy/presentation/widgets/text_display_container.dart';
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
    BuildContext context, {
    required bool isSourceLang,
  }) {
    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView(
            children: SupportedLanguages.languages.entries.map((entry) {
              final isDisabled = (isSourceLang && entry.key == targetLang) ||
                  (!isSourceLang && entry.key == sourceLang);

              return ListTile(
                leading: Icon(
                  entry.key == (isSourceLang ? sourceLang : targetLang)
                      ? Icons.check
                      : null,
                ),
                title: Text(
                  '${SupportedLanguages.getFlag(entry.key)} ${SupportedLanguages.getLanguage(entry.key)}',
                ),
                onTap: isDisabled
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
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.25)
                    : null,
              );
            }).toList(),
          ),
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

    if (translationState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translationState.error!)),
        );
      });
    }

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
              TextDisplayContainer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        LanguageSelectorButton(
                          languageCode: sourceLang,
                          onTap: () => showLanguageBottomSheet(
                            context,
                            isSourceLang: true,
                          ),
                        ),
                        const Spacer(),
                        CustomIconButton(
                          icon: Icons.swap_vert,
                          onPressed: translationState.isLoading ||
                                  translationState.translation != null
                              ? null
                              : switchLanguages,
                          tooltip: 'Switch languages',
                        ),
                        const Gap(8),
                        CustomIconButton(
                          icon: Icons.clear,
                          onPressed: translationState.isLoading ||
                                  translationState.translation != null
                              ? () {}
                              : () => sourceTextController.clear(),
                          tooltip: 'Clear source text',
                        ),
                      ],
                    ),
                    LanguageTextField(
                      controller: sourceTextController,
                      hintText: 'Enter text to translate...',
                      isReadOnly: translationState.isLoading,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              TextDisplayContainer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        LanguageSelectorButton(
                          languageCode: targetLang,
                          onTap: () => showLanguageBottomSheet(
                            context,
                            isSourceLang: false,
                          ),
                        ),
                        const Spacer(),
                        CustomIconButton(
                          icon: Icons.copy,
                          onPressed: translationState.isLoading ||
                                  translationState.translation == null
                              ? () {}
                              : () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: translatedTextController.text,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Text copied to clipboard!'),
                                    ),
                                  );
                                },
                          tooltip: 'Copy translation',
                        ),
                      ],
                    ),
                    LanguageTextField(
                      controller: translatedTextController,
                      hintText: 'Translation will appear here...',
                      isReadOnly: true,
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
                  minimumSize: const Size.fromHeight(40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
