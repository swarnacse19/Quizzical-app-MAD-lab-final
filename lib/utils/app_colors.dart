import 'package:flutter/material.dart';

/// Central color palette matching the Figma design.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF2E2E3A);
  static const Color textSecondary = Color(0xFF8A8A96);

  static const Color primaryDark = Color(0xFF0B4A45); // buttons
  static const Color primaryDarkPressed = Color(0xFF083733);

  static const Color cardWhite = Color(0xFFFAFAFA);
  static const Color progressBar = Color(0xFF4C7CF3);

  static const Color correct = Color(0xFFA8D8B9);
  static const Color correctBorder = Color(0xFF4FAE71);
  static const Color incorrect = Color(0xFFF6A6A0);
  static const Color incorrectBorder = Color(0xFFE0574C);

  static const Color resultGood = Color(0xFFA8D8B9);
  static const Color resultGoodText = Color(0xFF1E5B36);
  static const Color resultBad = Color(0xFFFF6B4A);
  static const Color resultBadText = Color(0xFFFFFFFF);

  // Category card background palette, cycled by index.
  static const List<Color> categoryPalette = [
    Color(0xFFAFC9F0), // blue
    Color(0xFFBFE6C9), // mint
    Color(0xFFF3E7B0), // yellow
    Color(0xFFDCC2F0), // purple
    Color(0xFFF6C6CE), // pink
    Color(0xFFF7DCB8), // peach
  ];
}