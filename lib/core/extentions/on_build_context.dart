import 'package:flutter/material.dart';

extension BuildContextUtils on BuildContext {
  /// Returns the current [ThemeData] of the context.
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme] of the context.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Shows a SnackBar with the given [message].
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Hides all SnackBars in the context.
  void hideAllSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }
}
