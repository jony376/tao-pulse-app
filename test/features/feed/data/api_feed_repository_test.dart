import 'package:flutter_test/flutter_test.dart';
import 'package:taopulse/features/feed/data/api_feed_repository.dart';

void main() {
  group('FeedItemMapper.fromJson', () {
    test('normalizes mixed tag values safely', () {
      final item = FeedItemMapper.fromJson({
        'id': '1',
        'category': 'validator',
        'title': 'Title',
        'summary': 'Summary',
        'insight': 'Insight',
        'time_ago': '1m',
        'impact': 'high',
        'tags': ['alpha', 7, null, {'k': 'v'}, '   '],
      });

      expect(item.tags, ['alpha', '7', '{k: v}']);
    });

    test('returns empty tags for non-list payload', () {
      final item = FeedItemMapper.fromJson({
        'id': '2',
        'category': 'validator',
        'title': 'Title',
        'summary': 'Summary',
        'insight': 'Insight',
        'time_ago': '1m',
        'impact': 'high',
        'tags': 'invalid',
      });

      expect(item.tags, isEmpty);
    });
  });
}
