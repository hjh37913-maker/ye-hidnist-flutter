import 'package:flutter/material.dart';

class AppShadows {
  static List<BoxShadow> soft(BuildContext context) => [
    BoxShadow(
      color: Theme.of(context).colorScheme.shadow.withValues(alpha: .08),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
}
