import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle title(BuildContext c) => Theme.of(c).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w700);
  static TextStyle subtitle(BuildContext c) => Theme.of(c).textTheme.bodyMedium!.copyWith(color: Theme.of(c).colorScheme.onSurfaceVariant);
  static TextStyle section(BuildContext c) => Theme.of(c).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700);
}
