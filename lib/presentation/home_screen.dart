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
    BuildContext context, {
    required bool isSourceLang,
  }) {
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: () => translationState.isLoading
                                ? null
                                : showLanguageBottomSheet(
                                    context,
                                    isSourceLang: true,
                                  ),
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.grey[600],
                              backgroundColor: Colors.grey[300],
                            ),
                            icon: Text(SupportedLanguages.getFlag(sourceLang)),
                            label: Row(
                              children: [
                                Text(
                                  SupportedLanguages.getLanguage(sourceLang),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: translationState.isLoading ||
                                    translationState.translation != null
                                ? null
                                : () {
                                    sourceTextController.clear();
                                  },
                            icon: const Icon(Icons.clear),
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.grey[600],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextField(
                          controller: sourceTextController,
                          maxLines: null,
                          expands: true,
                          maxLength: 100,
                          textAlign: TextAlign.center,
                          enabled: !translationState.isLoading,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Enter text to translate...',
                            counter: SizedBox(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: () => translationState.isLoading
                                ? null
                                : showLanguageBottomSheet(
                                    context,
                                    isSourceLang: false,
                                  ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.grey[600],
                              backgroundColor: Colors.grey[300],
                            ),
                            icon: Text(SupportedLanguages.getFlag(targetLang)),
                            label: Text(
                              SupportedLanguages.getLanguage(targetLang),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed:
                                translationState.isLoading ? null : () {},
                            icon: const Icon(Icons.copy),
                            style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Colors.grey[600],
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
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
                                      content:
                                          Text('Text copied to clipboard!'),
                                    ),
                                  );
                                },
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: 'Translation will appear here...',
                          ),
                        ),
                      ),
                    ],
                  ),
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
