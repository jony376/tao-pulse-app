import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../theme/theme.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.showSearch = true,
    this.rightIcons,
    this.rightActions,
  });

  final String title;
  final bool showSearch;
  final List<IconData>? rightIcons;
  final List<AppTopBarAction>? rightActions;

  @override
  Widget build(BuildContext context) {
    final actions =
        rightActions ??
        ((rightIcons ?? (showSearch ? const [Icons.search] : const []))
            .map((icon) => AppTopBarAction(icon: icon))
            .toList());
    const leftBrandWidth = 118.0;
    final rightActionWidth = actions.isEmpty ? 0.0 : (actions.length * 40.0);
    final sideInset = math.max(leftBrandWidth, rightActionWidth);

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: leftBrandWidth,
              child: Align(
                alignment: Alignment.centerLeft,
                child: _TaoPulseBrand(),
              ),
            ),
          ),
          if (actions.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: sideInset,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.max,
                  children: actions
                      .map((action) => _TopBarIconButton(action: action))
                      .toList(),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sideInset),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AppTopBarAction {
  const AppTopBarAction({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;
}

class _TopBarIconButton extends StatelessWidget {
  const _TopBarIconButton({required this.action});

  final AppTopBarAction action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: IconButton(
        onPressed: action.onPressed ?? () {},
        icon: Icon(action.icon, color: AppColors.textPrimary, size: 24),
        splashRadius: 20,
      ),
    );
  }
}

class _TaoPulseBrand extends StatelessWidget {
  const _TaoPulseBrand();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.aiPurple.withValues(alpha: 0.8),
            ),
          ),
          child: const Icon(
            Icons.graphic_eq,
            color: AppColors.aiPurple,
            size: 18,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            children: const [
              TextSpan(
                text: 'Tao',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: 'Pulse',
                style: TextStyle(color: AppColors.aiPurple),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
