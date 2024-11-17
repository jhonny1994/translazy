import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translazy/core/localization/generated/l10n.dart';
import 'package:translazy/core/supported_languages.dart';
import 'package:translazy/domain/translation_model.dart';
import 'package:translazy/presentation/widgets/custom_icon_button.dart';
import 'package:translazy/presentation/widgets/language_selector_button.dart';
import 'package:translazy/presentation/widgets/language_text_field.dart';
import 'package:translazy/presentation/widgets/text_display_container.dart';
import 'package:translazy/providers/history_notifier_provider.dart';
import 'package:translazy/providers/translation_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String sourceLang;
  late String targetLang;
  late stt.SpeechToText _speech;

  TextEditingController sourceTextController = TextEditingController();
  TextEditingController translatedTextController = TextEditingController();

  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    sourceLang = 'en';
    targetLang = 'ar';
    _speech = stt.SpeechToText();
  }

  Future<void> _startListening() async {
    if (!_isListening) {
      final available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        if (mounted) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
        await _speech.listen(
          onResult: (val) => setState(() {
            sourceTextController.text = val.recognizedWords;
          }),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).sttNotAvailable)),
          );
        }
      }
    }
  }

  Future<void> _stopListening() async {
    setState(() => _isListening = false);
    await _speech.stop();
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
                onTap: isDisabled || _isListening
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
      final record = TranslationRecord(
        sourceText: sourceTextController.text,
        translatedText: translationState.translation!,
        sourceLang: sourceLang,
        targetLang: targetLang,
        timestamp: DateTime.now(),
      );
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(historyProvider.notifier).addRecord(record),
      );
    }
    return Scaffold(
      body: Column(
        children: [
          TextDisplayContainer(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LanguageSelectorButton(
                        languageCode: sourceLang,
                        onTap: () => showLanguageBottomSheet(
                          context,
                          isSourceLang: true,
                        ),
                      ),
                    ),
                    const Gap(8),
                    CustomIconButton(
                      icon: _isListening ? Icons.mic : Icons.mic_none,
                      onPressed: translationState.isLoading ||
                              translationState.translation != null
                          ? null
                          : _isListening
                              ? _stopListening
                              : _startListening,
                      tooltip: _isListening
                          ? S.of(context).stopListening
                          : S.of(context).startListening,
                    ),
                    const Gap(8),
                    CustomIconButton(
                      icon: Icons.clear,
                      onPressed: _isListening ||
                              translationState.isLoading ||
                              translationState.translation != null
                          ? () {}
                          : () => sourceTextController.clear(),
                      tooltip: S.of(context).clearSourceText,
                    ),
                  ],
                ),
                LanguageTextField(
                  controller: sourceTextController,
                  hintText: S.of(context).enterTextToTranslate,
                  isReadOnly: _isListening || translationState.isLoading,
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
                    Expanded(
                      child: LanguageSelectorButton(
                        languageCode: targetLang,
                        onTap: () => _isListening
                            ? null
                            : showLanguageBottomSheet(
                                context,
                                isSourceLang: false,
                              ),
                      ),
                    ),
                    const Gap(8),
                    CustomIconButton(
                      icon: Icons.swap_vert,
                      onPressed: _isListening ||
                              translationState.isLoading ||
                              translationState.translation != null
                          ? null
                          : switchLanguages,
                      tooltip: S.of(context).switchLanguages,
                    ),
                    const Gap(8),
                    CustomIconButton(
                      icon: Icons.copy,
                      onPressed: _isListening ||
                              translationState.isLoading ||
                              translationState.translation == null
                          ? () {}
                          : () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: translatedTextController.text,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    S.of(context).textCopiedToClipboard,
                                  ),
                                ),
                              );
                            },
                      tooltip: S.of(context).copyTranslation,
                    ),
                  ],
                ),
                LanguageTextField(
                  controller: translatedTextController,
                  hintText: S.of(context).translationWillAppearHere,
                  isReadOnly: true,
                ),
              ],
            ),
          ),
          const Gap(8),
          ElevatedButton(
            onPressed: _isListening ||
                    translationState.isLoading ||
                    translationState.error != null
                ? null
                : () async {
                    if (translationState.translation != null) {
                      // Clear the text in controllers
                      sourceTextController.clear();
                      translatedTextController.clear();

                      // Reset translation state
                      ref.read(translationProvider.notifier).clearTranslation();
                    } else {
                      final textToTranslate = sourceTextController.text;

                      // Wait for the translation to complete
                      await ref.read(translationProvider.notifier).translate(
                            textToTranslate,
                            sourceLang,
                            targetLang,
                          );
                    }
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: translationState.isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  )
                : Text(
                    translationState.translation != null
                        ? S.of(context).clear
                        : S.of(context).translate,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
