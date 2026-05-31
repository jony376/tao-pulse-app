import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';

final askAiRepositoryProvider = Provider<AskAiRepository>((ref) {
  return AskAiRepository(ref.watch(apiClientProvider));
});

final askAiDashboardProvider = FutureProvider<AskAiDashboard>((ref) async {
  return ref.watch(askAiRepositoryProvider).getDashboard();
});

class AskAiRepository {
  AskAiRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<AskAiDashboard> getDashboard() async {
    final results = await Future.wait([
      _apiClient.get('/api/v1/chat/suggestions'),
      _apiClient.get('/api/v1/chat/history'),
    ]);
    final suggestionsData = results[0];
    final historyData = results[1];

    final suggestions =
        (suggestionsData['items'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map(AskAiPrompt.fromJson)
            .toList();
    final history = (historyData['items'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(ChatHistoryItem.fromJson)
        .toList();

    return AskAiDashboard(suggestions: suggestions, history: history);
  }

  Future<ChatReply> sendMessage(String message, {String? threadId}) async {
    final data = await _apiClient.post(
      '/api/v1/chat',
      data: {'message': message, 'thread_id': threadId},
    );
    return ChatReply.fromJson(data);
  }
}

class AskAiDashboard {
  const AskAiDashboard({required this.suggestions, required this.history});

  final List<AskAiPrompt> suggestions;
  final List<ChatHistoryItem> history;
}

class AskAiPrompt {
  const AskAiPrompt({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.topic,
  });

  final String id;
  final String title;
  final String subtitle;
  final String topic;

  factory AskAiPrompt.fromJson(Map<String, dynamic> json) {
    return AskAiPrompt(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
    );
  }
}

class ChatHistoryItem {
  const ChatHistoryItem({
    required this.id,
    required this.title,
    required this.timeAgo,
  });

  final String id;
  final String title;
  final String timeAgo;

  factory ChatHistoryItem.fromJson(Map<String, dynamic> json) {
    return ChatHistoryItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      timeAgo: json['time_ago'] as String? ?? '',
    );
  }
}

class ChatReply {
  const ChatReply({
    required this.threadId,
    required this.content,
    required this.sources,
  });

  final String threadId;
  final String content;
  final List<String> sources;

  factory ChatReply.fromJson(Map<String, dynamic> json) {
    final message = json['message'] as Map<String, dynamic>? ?? const {};
    return ChatReply(
      threadId: json['thread_id'] as String? ?? '',
      content: message['content'] as String? ?? '',
      sources: _stringListOf(message['sources']),
    );
  }
}

List<String> _stringListOf(Object? value) {
  if (value is! List) return const [];
  return value
      .where((item) => item != null)
      .map((item) => item.toString().trim())
      .where((item) => item.isNotEmpty)
      .toList();
}
