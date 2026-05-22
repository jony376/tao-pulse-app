import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../data/subnets_repository.dart';

class SubnetsScreen extends ConsumerWidget {
  const SubnetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subnetsAsync = ref.watch(subnetsProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: AppSpacing.md,
        title: const AppTopBar(title: 'Subnets'),
      ),
      body: subnetsAsync.when(
        data: (subnets) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(4, AppSpacing.md, 4, 108),
          itemCount: subnets.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) => _SubnetCard(subnet: subnets[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('Failed to load subnets: $error'),
        ),
      ),
    );
  }
}

class _SubnetCard extends StatelessWidget {
  const _SubnetCard({required this.subnet});

  final SubnetSummary subnet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${subnet.name}  SN${subnet.netuid}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: subnet.watching
                      ? AppColors.aiPurple.withValues(alpha: 0.16)
                      : Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  subnet.watching ? 'Watching' : subnet.status,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: subnet.watching ? AppColors.aiPurple : AppColors.textSecondary,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subnet.summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.35,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  label: 'Emission 24h',
                  value: '${subnet.emissionChangePct24h.toStringAsFixed(1)}%',
                ),
              ),
              Expanded(
                child: _MetricTile(
                  label: 'Stake 24h',
                  value: '${subnet.stakeChangeTao24h} TAO',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  label: 'Validators',
                  value: '${subnet.activeValidators}',
                ),
              ),
              Expanded(
                child: _MetricTile(
                  label: 'Miners',
                  value: '${subnet.activeMiners}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.smallCard),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
