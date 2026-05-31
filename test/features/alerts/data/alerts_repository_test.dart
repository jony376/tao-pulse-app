import 'package:flutter_test/flutter_test.dart';
import 'package:taopulse/features/alerts/data/alerts_repository.dart';

void main() {
  group('AlertSettings.fromJson', () {
    test('parses bool-like values without throwing', () {
      final settings = AlertSettings.fromJson({
        'subnet': {
          'name': 'Subnet 42',
          'netuid': 42,
          'watching': '1',
        },
        'activity_alerts': {
          'Validator updates': true,
          'Subnet updates': 'false',
          'Miner updates': 1,
        },
        'other_alerts': {
          'Governance': 'true',
          'System': 0,
          'Research': null,
        },
      });

      expect(settings.watching, isTrue);
      expect(settings.activityAlerts['Validator updates'], isTrue);
      expect(settings.activityAlerts['Subnet updates'], isFalse);
      expect(settings.activityAlerts['Miner updates'], isTrue);
      expect(settings.otherAlerts['Governance'], isTrue);
      expect(settings.otherAlerts['System'], isFalse);
      expect(settings.otherAlerts['Research'], isFalse);
    });

    test('falls back safely for unsupported values', () {
      final settings = AlertSettings.fromJson({
        'subnet': {
          'watching': 'not-a-bool',
        },
        'activity_alerts': {
          'Alpha': 2,
        },
        'other_alerts': {
          'Beta': 'maybe',
        },
      });

      expect(settings.watching, isFalse);
      expect(settings.activityAlerts['Alpha'], isFalse);
      expect(settings.otherAlerts['Beta'], isFalse);
    });
  });
}
