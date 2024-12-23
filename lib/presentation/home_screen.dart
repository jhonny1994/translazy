import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translazy/core/localization/generated/l10n.dart';
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
  late String targetLang;
  late stt.SpeechToText _speech;

  TextEditingController sourceTextController = TextEditingController();
  TextEditingController translatedTextController = TextEditingController();

  bool _isListening = false;
  bool _hasPermission = false;
  Timer? _silenceTimer;
  Timer? _maxDurationTimer;
  static const _maxListeningDuration = Duration(minutes: 2);
  static const _silenceTimeout = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    sourceLang = 'en';
    targetLang = 'ar';
    _speech = stt.SpeechToText();
    Future.delayed(Duration.zero, () async {
      try {
        _hasPermission = await _initializeSpeech();
        setState(() {});
      } catch (e) {
        _handleSpeechError(e);
      }
    });
    sourceTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    sourceTextController.dispose();
    translatedTextController.dispose();
    _silenceTimer?.cancel();
    _maxDurationTimer?.cancel();
    if (_isListening) {
      _speech.stop();
    }
    super.dispose();
  }

  Future<bool> _initializeSpeech() async {
    return _speech.initialize(
      onError: _handleSpeechError,
      onStatus: _handleSpeechStatus,
    );
  }

  void _handleSpeechError(dynamic error) {
    _silenceTimer?.cancel();
    _maxDurationTimer?.cancel();
    setState(() => _isListening = false);
    if (mounted) {
      final errorMessage =
          error is SpeechRecognitionError ? error.errorMsg : error.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(8),
        ),
      );
    }
  }

  void _handleSpeechStatus(String status) {
    if (status == 'done' || status == 'notListening' || status == 'error') {
      _silenceTimer?.cancel();
      _maxDurationTimer?.cancel();
      setState(() => _isListening = false);
    } else if (status == 'listening') {
      setState(() => _isListening = true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Listening...'),
            duration: const Duration(days: 365),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
            backgroundColor: Colors.blue,
            action: SnackBarAction(
              label: 'Stop',
              textColor: Colors.white,
              onPressed: _stopListening,
            ),
          ),
        );
      }
    }
  }

  Future<void> _startListening() async {
    // Reset timers
    _silenceTimer?.cancel();
    _maxDurationTimer?.cancel();

    if (!_hasPermission) {
      try {
        _hasPermission = await _initializeSpeech();
      } catch (e) {
        _handleSpeechError('Failed to initialize speech: $e');
        return;
      }
    }

    if (_hasPermission && !_isListening) {
      setState(() => _isListening = true);
      if (mounted) {
        FocusScope.of(context).requestFocus(FocusNode());
      }

      try {
        final selectedLocale = await _speech.locales();
        final matchingLocale = selectedLocale.firstWhere(
          (locale) => locale.localeId.startsWith(sourceLang),
          orElse: () => selectedLocale.first,
        );

        // Set max duration timer
        _maxDurationTimer = Timer(_maxListeningDuration, () {
          if (_isListening) {
            _stopListening();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(S.of(context).maxListeningDurationReached),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(8),
                ),
              );
            }
          }
        });

        await _speech.listen(
          onResult: (val) {
            if (!mounted) return;
            setState(() {
              if (val.recognizedWords.isNotEmpty) {
                sourceTextController.text = val.recognizedWords;
              }
            });

            // Reset silence timer on new results
            _silenceTimer?.cancel();
            if (val.finalResult) {
              _silenceTimer = Timer(_silenceTimeout, () {
                if (_isListening && mounted) {
                  _stopListening();
                }
              });
            }
          },
          localeId: matchingLocale.localeId,
        );
      } catch (e) {
        _handleSpeechError(e);
      }
    } else if (!_hasPermission) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).microphonePermissionDenied),
            backgroundColor: Theme.of(context).colorScheme.error,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
          ),
        );
      }
    }
  }

  Future<void> _stopListening() async {
    _silenceTimer?.cancel();
    _maxDurationTimer?.cancel();
    setState(() => _isListening = false);
    await _speech.stop();
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
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
                    ? Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.25)
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
          SnackBar(
            content: Text(translationState.error!),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
          ),
        );
      });
    }

    if (translationState.translation != null &&
        translationState.translation != translatedTextController.text) {
      translatedTextController.text = translationState.translation!;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextDisplayContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        onPressed: translationState.isLoading
                            ? null
                            : _isListening
                                ? _stopListening
                                : _startListening,
                        tooltip: _isListening
                            ? S.of(context).stopListening
                            : S.of(context).startListening,
                        color: _isListening ? Colors.red : null,
                      ),
                      const Gap(8),
                      CustomIconButton(
                        icon: Icons.clear,
                        onPressed: _isListening ||
                                translationState.isLoading ||
                                sourceTextController.text.trim().isEmpty
                            ? null
                            : () {
                                sourceTextController.clear();
                                translatedTextController.clear();
                                if (translationState.translation != null) {
                                  ref
                                      .read(translationProvider.notifier)
                                      .clearTranslation();
                                }
                              },
                        tooltip: S.of(context).clearSourceText,
                      ),
                    ],
                  ),
                  const Gap(8),
                  LanguageTextField(
                    controller: sourceTextController,
                    hintText: S.of(context).enterTextToTranslate,
                    isReadOnly: _isListening || translationState.isLoading,
                    onChanged: (text) {
                      if (translationState.translation != null) {
                        ref
                            .read(translationProvider.notifier)
                            .clearTranslation();
                      }
                    },
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
                          onTap: () => showLanguageBottomSheet(
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
                                sourceTextController.text.trim().isNotEmpty
                            ? null
                            : switchLanguages,
                        tooltip: S.of(context).switchLanguages,
                      ),
                      const Gap(8),
                      CustomIconButton(
                        icon: Icons.copy,
                        onPressed: _isListening ||
                                translationState.isLoading ||
                                translationState.translation == null ||
                                translatedTextController.text.trim().isEmpty
                            ? null
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
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(8),
                                  ),
                                );
                              },
                        tooltip: S.of(context).copyTranslation,
                      ),
                    ],
                  ),
                  const Gap(8),
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
                      (translationState.translation == null &&
                          sourceTextController.text.trim().isEmpty)
                  ? null
                  : () async {
                      if (translationState.translation != null) {
                        sourceTextController.clear();
                        translatedTextController.clear();
                        ref
                            .read(translationProvider.notifier)
                            .clearTranslation();
                      } else {
                        final textToTranslate = sourceTextController.text;
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
                shadowColor: Colors.black.withValues(alpha: 0.3),
              ),
              child: translationState.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      translationState.translation != null
                          ? S.of(context).clear
                          : S.of(context).translate,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
