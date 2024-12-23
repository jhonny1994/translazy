import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/core/core.dart';
import 'package:translazy/domain/domain.dart';
import 'package:translazy/providers/providers.dart';

class TranslationNotifier extends StateNotifier<TranslationState> {
  TranslationNotifier(this.dio, this.ref) : super(TranslationState.initial());

  final Dio dio;
  final Ref ref;

  Timer? _debounceTimer;
  String? _lastSourceLang;
  String? _lastTargetLang;
  String? _lastText;
  final _requestQueue = <DateTime>[];

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void clearTranslation() {
    _debounceTimer?.cancel();
    _lastText = null;
    _lastSourceLang = null;
    _lastTargetLang = null;
    state = TranslationState.initial();
  }

  Future<void> translate(
    String text,
    String sourceLang,
    String targetLang,
  ) async {
    // Don't translate if nothing changed
    if (text == _lastText &&
        sourceLang == _lastSourceLang &&
        targetLang == _lastTargetLang) {
      return;
    }

    _lastText = text;
    _lastSourceLang = sourceLang;
    _lastTargetLang = targetLang;

    // Cancel previous timer if it exists
    _debounceTimer?.cancel();

    // Input validation
    if (text.isEmpty) {
      state = state.copyWith(
        error: S.current.emptyTextError,
        isLoading: false,
      );
      return;
    }

    if (text.length > ApiConstants.maxInputLength) {
      state = state.copyWith(
        error: S.current.textTooLongError(ApiConstants.maxInputLength),
        isLoading: false,
      );
      return;
    }

    // Set loading state
    state = state.copyWith(
      isLoading: true,
      error: null,
    );

    // Debounce for 500ms
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // Rate limiting
      if (!_canMakeRequest()) {
        state = state.copyWith(
          error:
              S.current.rateLimitError(ApiConstants.rateLimitWindow.inSeconds),
          isLoading: false,
        );
        return;
      }

      try {
        _addRequest();
        final response = await dio
            .get<Map<String, dynamic>>(
              ApiConstants.translateEndpoint,
              queryParameters: {
                'text': text,
                'source_lang': sourceLang,
                'target_lang': targetLang,
              },
              options: Options(
                sendTimeout: ApiConstants.requestTimeout,
                receiveTimeout: ApiConstants.requestTimeout,
              ),
            )
            .timeout(
              ApiConstants.requestTimeout,
              onTimeout: () => throw TimeoutException(
                S.current.timeoutError(ApiConstants.requestTimeout.inSeconds),
              ),
            );

        if (response.statusCode == 200) {
          final translatedText = (response.data!['response']
              as Map<String, dynamic>)['translated_text'] as String;

          // Save to history
          await ref.read(historyProvider.notifier).addRecord(
                TranslationRecord(
                  sourceText: text,
                  translatedText: translatedText,
                  sourceLang: sourceLang,
                  targetLang: targetLang,
                  timestamp: DateTime.now(),
                ),
              );

          state = state.copyWith(
            translation: translatedText,
            isLoading: false,
          );
        } else {
          throw TranslationError(
            S.current.apiError(
              response.statusCode ?? 0,
              response.statusMessage ?? '',
            ),
          );
        }
      } on DioException catch (e) {
        String errorMessage;
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          errorMessage =
              S.current.timeoutError(ApiConstants.requestTimeout.inSeconds);
        } else if (e.response != null) {
          errorMessage = S.current.apiError(
            e.response?.statusCode ?? 0,
            e.response?.statusMessage ?? '',
          );
        } else {
          errorMessage = S.current.networkError;
        }
        state = state.copyWith(error: errorMessage, isLoading: false);
      } catch (e) {
        state = state.copyWith(
          error: S.current.unexpectedError(e.toString()),
          isLoading: false,
        );
      }
    });
  }

  void _addRequest() {
    _requestQueue.add(DateTime.now());
  }

  bool _canMakeRequest() {
    final now = DateTime.now();
    _requestQueue.removeWhere(
      (time) => now.difference(time) > ApiConstants.rateLimitWindow,
    );
    return _requestQueue.length < ApiConstants.maxRequestsPerWindow;
  }
}
