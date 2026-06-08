import 'package:flutter/material.dart';

import 'app_icon_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }
}
