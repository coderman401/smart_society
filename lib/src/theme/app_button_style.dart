import 'package:flutter/material.dart';

class AppButtonStyles {
  static ButtonStyle filled(context,
      {Color? foregroundColor, Color? backgroundColor}) {
    foregroundColor =
        foregroundColor ?? Theme.of(context).colorScheme.onPrimary;
    backgroundColor = backgroundColor ?? Theme.of(context).colorScheme.primary;
    return ElevatedButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            padding: const EdgeInsets.fromLTRB(32, 8, 32, 8))
        .copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
  }

  static ButtonStyle filledTonal(context,
      {Color? foregroundColor, Color? backgroundColor}) {
    foregroundColor =
        foregroundColor ?? Theme.of(context).colorScheme.onSecondaryContainer;
    backgroundColor =
        backgroundColor ?? Theme.of(context).colorScheme.secondaryContainer;
    return ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
  }

  static ButtonStyle outlined(context, {double borderWith = 1, Color? color}) {
    color = color ?? Theme.of(context).colorScheme.primary;
    return OutlinedButton.styleFrom(
      side: BorderSide(color: color, width: borderWith),
      foregroundColor: color,
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
  }

  static ButtonStyle dangerText(context) => TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
      );

  static ButtonStyle textButton(context, {Color? color}) {
    color = color ?? Theme.of(context).colorScheme.primary;
    return TextButton.styleFrom(
      foregroundColor: color,
    );
  }

  static inverse(context) => ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      );

  static raised(context, {bool roundBorder = false}) =>
      ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: roundBorder == false
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )
              : null);

  static outlinedCustom(context) => ElevatedButton.styleFrom();
}
