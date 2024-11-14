import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:translazy/core/supported_languages.dart';
import 'package:translazy/providers/history_notifier_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Scaffold(
      floatingActionButton: history.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () async {
                await ref.read(historyProvider.notifier).clearHistory();
              },
              tooltip: 'Clear History',
              child: const Icon(Icons.delete),
            ),
      body: history.isEmpty
          ? const Center(
              child: Text('No translations yet'),
            )
          : ListView.separated(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final record = history[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.85),
                    boxShadow: const [
                      BoxShadow(blurRadius: 8, color: Colors.black26),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    SupportedLanguages.getFlag(
                                      record.sourceLang,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    SupportedLanguages.getLanguage(
                                      record.sourceLang,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(4),
                          Icon(Icons.swap_horiz, color: Colors.grey[600]),
                          const Gap(4),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    SupportedLanguages.getFlag(
                                      record.targetLang,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    SupportedLanguages.getLanguage(
                                      record.targetLang,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Text(
                          record.sourceText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const Gap(4),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 16,
                        ),
                        child: Text(
                          record.translatedText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Center(
                        child: Text(
                          '${record.timestamp.day}/${record.timestamp.month}/${record.timestamp.year} - ${record.timestamp.hour}:${record.timestamp.minute}',
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(8),
            ),
    );
  }
}
