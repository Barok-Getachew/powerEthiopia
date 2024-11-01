import 'package:ethiosolar_app/app/core/exports/app_exports.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

// Define a light theme for the application
final light_theme = ThemeData(
  useMaterial3: true, // Enable Material 3 design

  // Define the color scheme for the light theme
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(67, 194, 89, 1), // Primary color for app
    onPrimary: Colors.white, // Text color on primary
    secondary: Color.fromRGBO(227, 165, 127, 100), // Secondary color
    onSecondary: Colors.white, // Text color on secondary
    error: Colors.red, // Error color
    onError: Colors.white, // Text color on error
    surface: Color(0xFFFAFAFA), // Surface background color
    onSurface: Colors.black, // Text color on surface
  ),

  // Text theme styles for different text elements
  textTheme: TextTheme(
    // Large, bold, black text (used for headlines)
    headlineLarge: TextStyle(
      fontSize: 18.adaptSize,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    ),

    // Medium, bold, white text (used for subheadings)
    headlineMedium: TextStyle(
      fontSize: 12.adaptSize,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),

    // Small white text (used for small details)
    headlineSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    // Very small, light black text (used for captions or footnotes)
    bodySmall: TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    ),

    // Medium, bold, black text (used for body text)
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    ),

    // Small, bold, black text (used for display elements)
    displayMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      overflow: TextOverflow.ellipsis,
    ),

    // Large label text, semi-transparent black (used for prominent labels)
    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: const Color.fromARGB(111, 0, 0, 0),
      overflow: TextOverflow.ellipsis,
    ),

    // Medium label text, semi-transparent black (used for secondary labels)
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: const Color.fromARGB(184, 0, 0, 0),
      overflow: TextOverflow.ellipsis,
    ),

    // Large, bold, white text (used for primary body elements)
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  // Elevated button theme (primary button style)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor, // Button background color
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
      ),
    ),
  ),

  // Outlined button theme (secondary button style)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
      ),
    ),
  ),

  // Font family setting, with dynamic selection based on locale
  fontFamily: Get.locale?.countryCode == 'ET'
      ? 'Nyala' // Font for Ethiopian language (e.g., Amharic)
      : GoogleFonts.poppins().fontFamily, // Default font for other locales
);
