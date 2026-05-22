import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/app_top_bar.dart';
import '../../../shared/widgets/feature_placeholder.dart';

class SubnetsScreen extends StatelessWidget {
  const SubnetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: AppSpacing.md,
        title: const AppTopBar(title: 'Subnets'),
      ),
      body: const FeaturePlaceholder(
        title: 'Subnets',
        subtitle: 'Coming soon.',
      ),
    );
  }
}
