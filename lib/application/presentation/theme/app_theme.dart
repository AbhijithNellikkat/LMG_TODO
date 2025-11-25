import 'package:flutter/material.dart';
import 'package:lmg_todo/application/presentation/utils/colors.dart';

class AppThemes {
  // Light Theme Configuration
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Lufga',
      primaryColor: kprimary,
      brightness: Brightness.light,

      scaffoldBackgroundColor: kwhite,
      colorScheme: const ColorScheme.light(
        primary: kprimary,
        onPrimary: kwhite,
        secondary: kgrey,
        onSecondary: kblack,
        error: kred,
        onError: kwhite,
        surface: kwhite,
        onSurface: kblack,
      ),
      dividerTheme: DividerThemeData(color: kgrey.withOpacity(0.4)),

      appBarTheme: const AppBarTheme(
        backgroundColor: koffwhite,
        foregroundColor: kblack,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: kblack,
        ),
      ),

      // cardTheme: const CardTheme(
      //   color: kwhite,
      //   shadowColor: kgrey,
      //   elevation: 0,
      // ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: koffwhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kgrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kprimary),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(color: kblack),

      navigationBarTheme: const NavigationBarThemeData(backgroundColor: kwhite),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kprimary,
          foregroundColor: kwhite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Add your preferred textTheme if needed
      // textTheme: TextTheme(...),
    );
  }

  // Dark Theme Configuration (starter template)
  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Lufga',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(
        primary: kprimary,
        onPrimary: kwhite,
        secondary: kgrey,
        onSecondary: kwhite,
        error: kred,
        onError: kwhite,
        surface: Color(0xFF121212),
        onSurface: kwhite,
      ),
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: kblack,
      //   foregroundColor: kwhite,
      //   elevation: 0,
      //   centerTitle: true,
      //   titleTextStyle: TextStyle(
      //     fontSize: 17,
      //     fontWeight: FontWeight.w500,
      //     color: kwhite,
      //   ),
      // ),
      // cardTheme: const CardTheme(
      //   color: Color(0xFF1E1E1E),
      //   elevation: 0,
      // ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: kgrey),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kprimary,
          foregroundColor: kwhite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
