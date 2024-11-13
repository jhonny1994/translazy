import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:translazy/core/constants.dart';
import 'package:translazy/core/exceptions.dart';
import 'package:translazy/domain/translation_state.dart';

class TranslationNotifier extends StateNotifier<TranslationState> {
  TranslationNotifier(this.dio) : super(TranslationState.initial());
  final Dio dio;

  Future<void> translate(
    String text,
    String sourceLang,
    String targetLang,
  ) async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await dio.get<Map<String, dynamic>>(
        ApiConstants.translateEndpoint,
        queryParameters: {
          'text': text,
          'source_lang': sourceLang,
          'target_lang': targetLang,
        },
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          translation: response.data!['translatedText'] as String,
          isLoading: false,
        );
      } else {
        throw TranslationError(
          'Error ${response.statusCode}: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw TranslationError(
          'API Error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        );
      } else {
        throw TranslationError('Network Error: ${e.message}');
      }
    } catch (e) {
      throw TranslationError('Unexpected Error: $e');
    }
  }
}
