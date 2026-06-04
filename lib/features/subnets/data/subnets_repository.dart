import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/api_client.dart';

final subnetsRepositoryProvider = Provider<SubnetsRepository>((ref) {
  return SubnetsRepository(ref.watch(apiClientProvider));
});

final subnetsProvider = FutureProvider<List<SubnetSummary>>((ref) async {
  return ref.watch(subnetsRepositoryProvider).getSubnets();
});

class SubnetsRepository {
  SubnetsRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<SubnetSummary>> getSubnets() async {
    final data = await _apiClient.get('/api/v1/subnets');
    return (data['items'] as List<dynamic>? ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(SubnetSummary.fromJson)
        .toList();
  }
}

class SubnetSummary {
  const SubnetSummary({
    required this.id,
    required this.name,
    required this.netuid,
    required this.summary,
    required this.watching,
    required this.description,
    required this.launchedAt,
    required this.alphaTokenCharacter,
    required this.emissionLabel,
    required this.emissionSummary,
    required this.emissionRank,
    required this.marketKeywords,
    required this.minersDo,
    required this.alphaPriceTao,
    required this.marketCapTao,
    required this.tvlTao,
    required this.volume24hTao,
    required this.activeValidators,
    required this.activeMiners,
  });

  final String id;
  final String name;
  final int netuid;
  final String summary;
  final bool watching;
  final String description;
  final DateTime? launchedAt;
  final String alphaTokenCharacter;
  final String emissionLabel;
  final String emissionSummary;
  final int emissionRank;
  final List<String> marketKeywords;
  final String minersDo;
  final double alphaPriceTao;
  final double marketCapTao;
  final double tvlTao;
  final double volume24hTao;
  final int activeValidators;
  final int activeMiners;

  factory SubnetSummary.fromJson(Map<String, dynamic> json) {
    final metrics = _mapOf(json['metrics']);
    final emissionStatus = _mapOf(json['emission_status']);
    return SubnetSummary(
      id: _stringOf(json['id'], fallback: _stringOf(json['netuid'])),
      name: _stringOf(json['name']),
      netuid: _intOf(json['netuid']),
      summary: _stringOf(json['summary']),
      watching: _boolOf(json['watching']),
      description: _stringOf(json['description']),
      launchedAt: DateTime.tryParse(_stringOf(json['launched_at'])),
      alphaTokenCharacter: _stringOf(json['alpha_token_character']),
      emissionLabel: _stringOf(emissionStatus['label']),
      emissionSummary: _stringOf(emissionStatus['summary']),
      emissionRank: _intOf(emissionStatus['rank']),
      marketKeywords: _stringListOf(json['market_keywords']),
      minersDo: _stringOf(json['miners_do']),
      alphaPriceTao: _doubleOf(metrics['alpha_price_tao']),
      marketCapTao: _doubleOf(metrics['market_cap_tao']),
      tvlTao: _doubleOf(metrics['tvl_tao']),
      volume24hTao: _doubleOf(metrics['volume_24h_tao']),
      activeValidators: _intOf(metrics['active_validators']),
      activeMiners: _intOf(metrics['active_miners']),
    );
  }
}

Map<String, dynamic> _mapOf(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  return const {};
}

String _stringOf(Object? value, {String fallback = ''}) {
  if (value == null) {
    return fallback;
  }
  if (value is String) {
    return value;
  }
  return value.toString();
}

List<String> _stringListOf(Object? value) {
  if (value is! List) {
    return const [];
  }

  return value
      .map((item) => _stringOf(item))
      .where((item) => item.isNotEmpty)
      .toList();
}

double _doubleOf(Object? value, {double fallback = 0}) {
  if (value is num) {
    return value.toDouble();
  }
  if (value is String) {
    return double.tryParse(value) ?? fallback;
  }
  return fallback;
}

int _intOf(Object? value, {int fallback = 0}) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value) ?? fallback;
  }
  return fallback;
}

bool _boolOf(Object? value, {bool fallback = false}) {
  if (value is bool) {
    return value;
  }
  if (value is String) {
    final normalized = value.trim().toLowerCase();
    if (normalized == 'true') {
      return true;
    }
    if (normalized == 'false') {
      return false;
    }
  }
  return fallback;
}
