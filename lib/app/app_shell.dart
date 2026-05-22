import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _tabs = <_TabItem>[
    _TabItem('Feed', Icons.graphic_eq, '/feed'),
    _TabItem('Subnets', Icons.hub_outlined, '/subnets'),
    _TabItem('Ask AI', Icons.smart_toy_outlined, '/ask-ai'),
    _TabItem('Alerts', Icons.notifications_outlined, '/alerts'),
    _TabItem('Settings', Icons.settings_outlined, '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final location = GoRouterState.of(context).uri.path;

    bool isSelected(_TabItem item) {
      return location == item.route || location.startsWith('${item.route}/');
    }

    void goToTab(_TabItem item) {
      if (!isSelected(item)) {
        context.go(item.route);
      }
    }

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SizedBox(
          height: 112 + bottomInset,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 78 + bottomInset,
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.xl,
                    AppSpacing.sm + bottomInset,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: _NavItem(
                          item: _tabs[0],
                          isSelected: isSelected(_tabs[0]),
                          onTap: () => goToTab(_tabs[0]),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          item: _tabs[1],
                          isSelected: isSelected(_tabs[1]),
                          onTap: () => goToTab(_tabs[1]),
                        ),
                      ),
                      const SizedBox(width: 88),
                      Expanded(
                        child: _NavItem(
                          item: _tabs[3],
                          isSelected: isSelected(_tabs[3]),
                          onTap: () => goToTab(_tabs[3]),
                        ),
                      ),
                      Expanded(
                        child: _NavItem(
                          item: _tabs[4],
                          isSelected: isSelected(_tabs[4]),
                          onTap: () => goToTab(_tabs[4]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: AppSpacing.sm + bottomInset,
                child: _AskAiNavItem(
                  isSelected: isSelected(_tabs[2]),
                  onTap: () => goToTab(_tabs[2]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  const _TabItem(this.label, this.icon, this.route);

  final String label;
  final IconData icon;
  final String route;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _TabItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.textPrimary : AppColors.navInactive;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.button),
      onTap: onTap,
      child: SizedBox(
        height: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 32),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 11,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AskAiNavItem extends StatelessWidget {
  const _AskAiNavItem({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.brand,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brandStart.withValues(alpha: 0.28),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.18),
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Ask AI',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 11,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
