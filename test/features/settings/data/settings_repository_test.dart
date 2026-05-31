import 'package:flutter_test/flutter_test.dart';
import 'package:taopulse/core/network/api_client.dart';
import 'package:taopulse/features/settings/data/settings_repository.dart';

class _FakeApiClient extends ApiClient {
  _FakeApiClient(this._responses);

  final Map<String, Map<String, dynamic>> _responses;

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = _responses[path];
    if (data == null) {
      throw StateError('No fake response for $path');
    }
    return data;
  }
}

void main() {
  test('parses numeric stats from int/num/string payloads', () async {
    final repo = SettingsRepository(
      _FakeApiClient({
        '/api/v1/profile': {
          'user': {'full_name': 'Jane Doe', 'initials': 'JD'},
          'stats': {
            'watching_entities': '14',
            'alerts_enabled': 6.0,
            'ai_conversations_this_month': '3',
          },
        },
        '/api/v1/settings': {
          'ai_preferences': {'response_style': 'balanced'},
          'appearance': {'theme': 'dark'},
        },
        '/api/v1/watchlist': {
          'items': [1, 2],
        },
        '/api/v1/alerts/settings': {
          'activity_alerts': {'validator': true, 'miner': false},
        },
      }),
    );

    final dashboard = await repo.getDashboard();

    expect(dashboard.watchingEntities, 14);
    expect(dashboard.alertsEnabled, 6);
    expect(dashboard.aiConversationsThisMonth, 3);
  });
}
