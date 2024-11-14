import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translazy/domain/translation_model.dart';

class HistoryNotifier extends StateNotifier<List<TranslationRecord>> {
  HistoryNotifier(this.prefs) : super([]) {
    loadHistory();
  }
  final SharedPreferences prefs;

  Future<void> loadHistory() async {
    final savedData = prefs.getStringList('translationHistory') ?? [];
    state = savedData
        .map(
          (jsonStr) => TranslationRecord.fromJson(
            json.decode(jsonStr) as Map<String, dynamic>,
          ),
        )
        .toList()
        .reversed
        .toList();
  }

  Future<void> addRecord(TranslationRecord record) async {
    state = [...state, record];
    await saveHistory();
  }

  Future<void> deleteRecord(int index) async {
    if (index >= 0 && index < state.length) {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
      await saveHistory();
    }
  }

  Future<void> clearHistory() async {
    state = [];
    await prefs.remove('translationHistory');
  }

  Future<void> saveHistory() async {
    final jsonList =
        state.map((record) => json.encode(record.toJson())).toList();
    await prefs.setStringList('translationHistory', jsonList);
  }
}
