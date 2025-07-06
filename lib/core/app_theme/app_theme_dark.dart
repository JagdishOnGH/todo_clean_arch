import 'package:flutter/material.dart';

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Colors.blue,
  onPrimary: Colors.white,
  primaryContainer: Colors.blue.shade700,
  onPrimaryContainer: Colors.white,
  secondary: Colors.blueGrey,
  onSecondary: Colors.white,
  secondaryContainer: Colors.blueGrey.shade700,
  onSecondaryContainer: Colors.white,
  surface: Colors.grey[900]!,
  onSurface: Colors.white,
  error: Colors.red,
  onError: Colors.white,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,

  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.surface,
    foregroundColor: darkColorScheme.onSurface,
    elevation: 0,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),

  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  ),

  listTileTheme: ListTileThemeData(
    iconColor: darkColorScheme.onSurfaceVariant,
    textColor: darkColorScheme.onSurface,
  ),

  dividerColor: Colors.transparent,
  // Hide up/down divider in ExpansionTile

  expansionTileTheme: const ExpansionTileThemeData(
    collapsedShape: RoundedRectangleBorder(),
    shape: RoundedRectangleBorder(),
    tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
    childrenPadding: EdgeInsets.symmetric(horizontal: 16.0),
    collapsedIconColor: Colors.white70,
    iconColor: Colors.white70,
  ),

  dialogBackgroundColor: darkColorScheme.surface,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkColorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: darkColorScheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    hintStyle: TextStyle(color: darkColorScheme.onSurfaceVariant),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(darkColorScheme.primary),
    checkColor: WidgetStateProperty.all(darkColorScheme.onPrimary),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: darkColorScheme.onPrimary,
      backgroundColor: darkColorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      foregroundColor: darkColorScheme.onSurface,
      iconSize: 24,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all(Colors.white.withValues(alpha: 0.1)),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      side: WidgetStateProperty.all(
        const BorderSide(color: Colors.white),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(darkColorScheme.onPrimary),
    backgroundColor: WidgetStateProperty.all(darkColorScheme.primary),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textStyle: WidgetStateProperty.all(
      const TextStyle(fontWeight: FontWeight.w600),
    ),
  )),
);
