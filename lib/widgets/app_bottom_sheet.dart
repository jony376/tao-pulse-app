import 'package:flutter/material.dart';

import '../theme/theme.dart';

Future<T?> showAppBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  String? title,
  Widget? trailing,
  bool isScrollControlled = true,
  bool showHandle = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: isScrollControlled,
    builder: (context) => AppBottomSheet(
      title: title,
      trailing: trailing,
      showHandle: showHandle,
      child: child,
    ),
  );
}

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.showHandle = true,
  });

  final Widget child;
  final String? title;
  final Widget? trailing;
  final bool showHandle;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    const resolvedPadding = EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.xxl,
    );

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: FigmaColors.neutralPrimary,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              resolvedPadding.left,
              resolvedPadding.top,
              resolvedPadding.right,
              resolvedPadding.bottom + bottomInset,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showHandle) ...[
                  const Center(child: _BottomSheetHandle()),
                  const SizedBox(height: 30),
                ],
                if (title != null || trailing != null) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (title != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: trailing != null ? AppSpacing.xxl : 0,
                            ),
                            child: Text(
                              title!,
                              style: FigmaTypography.h6Semibold.copyWith(
                                color: FigmaColors.textNeutralPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        if (trailing != null)
                          Align(
                            alignment: Alignment.centerRight,
                            child: trailing!,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomSheetHandle extends StatelessWidget {
  const _BottomSheetHandle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 4,
      decoration: BoxDecoration(
        color: FigmaColors.neutralTertiary,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
    );
  }
}
