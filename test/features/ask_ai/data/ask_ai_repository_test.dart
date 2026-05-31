import 'package:flutter_test/flutter_test.dart';
import 'package:taopulse/features/ask_ai/data/ask_ai_repository.dart';

void main() {
  group('ChatReply.fromJson', () {
    test('keeps valid sources and safely stringifies mixed values', () {
      final reply = ChatReply.fromJson({
        'thread_id': 't1',
        'message': {
          'content': 'hello',
          'sources': ['https://a', 42, null, {'url': 'x'}, '   '],
        },
      });

      expect(reply.threadId, 't1');
      expect(reply.content, 'hello');
      expect(reply.sources, ['https://a', '42', '{url: x}']);
    });

    test('returns empty list when sources is not a list', () {
      final reply = ChatReply.fromJson({
        'thread_id': 't2',
        'message': {'content': 'ok', 'sources': 'bad-type'},
      });

      expect(reply.sources, isEmpty);
    });
  });
}
