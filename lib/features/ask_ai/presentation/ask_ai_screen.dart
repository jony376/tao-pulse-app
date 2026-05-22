import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/app_top_bar.dart';

class AskAiScreen extends StatelessWidget {
  const AskAiScreen({super.key});

  static const _suggestedPrompts = <_PromptCardData>[
    _PromptCardData(
      title: 'Why is subnet 19 moving today?',
      subtitle: 'Explain the recent emission and stake changes',
      icon: Icons.trending_up,
      color: AppColors.aiPurple,
    ),
    _PromptCardData(
      title: 'Summarize today\'s ecosystem activity',
      subtitle: 'What are the most important events?',
      icon: Icons.article_outlined,
      color: Color(0xFF18E7C5),
    ),
    _PromptCardData(
      title: 'Which validators changed weights?',
      subtitle: 'Show recent validator weight shifts',
      icon: Icons.groups_outlined,
      color: Color(0xFFFFA055),
    ),
    _PromptCardData(
      title: 'Any unusual TAO stake movement?',
      subtitle: 'Detect large wallet transfers and flows',
      icon: Icons.account_balance_wallet_outlined,
      color: AppColors.aiPurple,
    ),
  ];

  static const _recentConversations = <_RecentConversationData>[
    _RecentConversationData(
      title: 'Subnet 19 analysis',
      timeAgo: '2 min ago',
      icon: Icons.trending_up,
      color: AppColors.aiPurple,
    ),
    _RecentConversationData(
      title: 'Validator rotation',
      timeAgo: '1 hr ago',
      icon: Icons.groups_outlined,
      color: AppColors.success,
    ),
    _RecentConversationData(
      title: 'Wallet 5F...a3d',
      timeAgo: '3 hr ago',
      icon: Icons.account_balance_wallet_outlined,
      color: AppColors.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: AppSpacing.md,
        title: const AppTopBar(
          title: 'Ask AI',
          showSearch: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          4,
          AppSpacing.md,
          4,
          12 + bottomInset,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _AskAiHero(),
            const SizedBox(height: AppSpacing.xxl),
            _SectionHeader(
              title: 'Suggested questions',
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 214,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _suggestedPrompts.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) => SizedBox(
                  width: 210,
                  child: _PromptCard(data: _suggestedPrompts[index]),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionHeader(
              title: 'Recent conversations',
              actionLabel: 'View all',
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 88,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _recentConversations.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) => SizedBox(
                  width: 170,
                  child: _RecentConversationCard(
                    data: _recentConversations[index],
                  ),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: AppSpacing.md),
            const _AskAiComposer(),
          ],
        ),
      ),
    );
  }
}

class _AskAiHero extends StatelessWidget {
  const _AskAiHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.displaySmall?.copyWith(
                fontSize: 22,
                height: 1.15,
              ),
              children: const [
                TextSpan(text: 'How can I help you\n'),
                TextSpan(
                  text: 'understand ',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                TextSpan(
                  text: 'Bittensor',
                  style: TextStyle(color: AppColors.aiPurple),
                ),
                TextSpan(text: ' today?'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Text(
              'Ask anything about subnets, validators, stake, emissions, or ecosystem activity.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.actionLabel,
  });

  final String title;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.auto_awesome,
          size: 18,
          color: AppColors.aiPurple.withValues(alpha: 0.95),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
          ),
        ),
        if (actionLabel != null)
          Text(
            actionLabel!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.aiPurple,
            ),
          ),
      ],
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.data});

  final _PromptCardData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(AppRadius.smallCard),
                ),
                child: Icon(data.icon, color: data.color, size: 21),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.textSecondary,
                size: 22,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            data.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 15,
              height: 1.15,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            data.subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _AskAiComposer extends StatelessWidget {
  const _AskAiComposer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0x667B5CFF),
            Color(0x55A855F7),
            Color(0x334F8CFF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Row(
          children: [
            _ComposerCircleButton(
              icon: Icons.add,
              backgroundColor: Colors.white.withValues(alpha: 0.04),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                'Ask anything about Bittensor...',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(
              Icons.mic_none,
              color: AppColors.textPrimary,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.md),
            const _ComposerCircleButton(
              icon: Icons.arrow_upward,
              backgroundColor: AppColors.aiPurple,
              iconColor: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentConversationCard extends StatelessWidget {
  const _RecentConversationCard({required this.data});

  final _RecentConversationData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppRadius.smallCard),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            child: Icon(data.icon, color: data.color, size: 18),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  data.timeAgo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _ComposerCircleButton extends StatelessWidget {
  const _ComposerCircleButton({
    required this.icon,
    required this.backgroundColor,
    this.iconColor = AppColors.textSecondary,
  });

  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}

class _PromptCardData {
  const _PromptCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class _RecentConversationData {
  const _RecentConversationData({
    required this.title,
    required this.timeAgo,
    required this.icon,
    required this.color,
  });

  final String title;
  final String timeAgo;
  final IconData icon;
  final Color color;
}
