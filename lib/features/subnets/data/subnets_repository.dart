import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';

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
    required this.status,
    required this.watching,
    required this.emissionChangePct24h,
    required this.stakeChangeTao24h,
    required this.activeValidators,
    required this.activeMiners,
  });

  final String id;
  final String name;
  final int netuid;
  final String summary;
  final String status;
  final bool watching;
  final double emissionChangePct24h;
  final int stakeChangeTao24h;
  final int activeValidators;
  final int activeMiners;

  factory SubnetSummary.fromJson(Map<String, dynamic> json) {
    final metrics = json['metrics'] as Map<String, dynamic>? ?? const {};
    return SubnetSummary(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      netuid: json['netuid'] as int? ?? 0,
      summary: json['summary'] as String? ?? '',
      status: json['status'] as String? ?? '',
      watching: json['watching'] as bool? ?? false,
      emissionChangePct24h:
          (metrics['emission_change_pct_24h'] as num? ?? 0).toDouble(),
      stakeChangeTao24h: metrics['stake_change_tao_24h'] as int? ?? 0,
      activeValidators: metrics['active_validators'] as int? ?? 0,
      activeMiners: metrics['active_miners'] as int? ?? 0,
    );
  }
}
