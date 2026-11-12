import 'package:flutter/material.dart';

class AppColors {
  // CulturePop Design Kit Palette (From PDF Spec)
  static const Color warmCream = Color(0xFFF9F6F0);
  static const Color creamCard = Color(0xFFFFFFFF);
  static const Color creamAccent = Color(0xFFF0EBE1);

  static const Color navyInk = Color(0xFF1A2238);
  static const Color navySoft = Color(0xFF2C3654);
  static const Color navyLight = Color(0xFF64748B);

  static const Color coral = Color(0xFFE76F51);
  static const Color coralLight = Color(0xFFFFECE8);
  
  static const Color peach = Color(0xFFF4A261);
  static const Color peachLight = Color(0xFFFFF3E8);

  static const Color sky = Color(0xFF8ECAE6);
  static const Color skyLight = Color(0xFFEBF6FC);

  static const Color lavender = Color(0xFFBDB2FF);
  static const Color lavenderLight = Color(0xFFF3F0FF);

  static const Color mint = Color(0xFF2A9D8F);
  static const Color mintLight = Color(0xFFE6F5F2);

  static const Color gold = Color(0xFFF59E0B);
  static const Color goldLight = Color(0xFFFEF3C7);

  // Extended palette for older screens and helpers
  static const Color background = warmCream;
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate400 = Color(0xFF94A3B8);

  static const Color emerald = Color(0xFF10B981);
  static const Color emeraldLight = Color(0xFFD1FAE5);

  static const Color rose = Color(0xFFF43F5E);
  static const Color roseLight = Color(0xFFFFE4E6);

  // Dark Mode Palette
  static const Color darkBackground = Color(0xFF0B0F19);
  static const Color darkCard = Color(0xFF161F30);
  static const Color darkCardBorder = Color(0xFF26334D);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkCoral = Color(0xFFFF7A59);
  static const Color darkCoralLight = Color(0x33FF7A59);

  // Dynamic Theme Context Helpers
  static Color getBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : warmCream;
  }

  static Color getCardBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCard
        : creamCard;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardBorder
        : creamAccent;
  }

  static Color getText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : navyInk;
  }

  static Color getSubtext(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : navyLight;
  }

  static Color getCoral(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCoral
        : coral;
  }
}

class AppDecorations {
  static BoxDecoration modernCard({
    Color? color,
    double radius = 22,
    double elevation = 6,
    BuildContext? context,
  }) {
    final isDark = context != null && Theme.of(context).brightness == Brightness.dark;
    final cardColor = color ?? (isDark ? AppColors.darkCard : Colors.white);
    final borderColor = isDark ? AppColors.darkCardBorder : Colors.transparent;

    return BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(radius),
      border: isDark ? Border.all(color: borderColor, width: 1) : null,
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withValues(alpha: 0.3)
              : AppColors.navyInk.withValues(alpha: 0.06),
          blurRadius: elevation * 2.5,
          offset: Offset(0, elevation * 0.7),
        ),
      ],
    );
  }
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.warmCream,
      primaryColor: AppColors.coral,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coral,
        primary: AppColors.coral,
        secondary: AppColors.navyInk,
        surface: AppColors.creamCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.navyInk),
        titleTextStyle: TextStyle(
          color: AppColors.navyInk,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.creamCard,
        elevation: 2,
        shadowColor: AppColors.navyInk.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),
      fontFamily: 'sans-serif',
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.darkCoral,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkCoral,
        brightness: Brightness.dark,
        primary: AppColors.darkCoral,
        secondary: AppColors.darkTextPrimary,
        surface: AppColors.darkCard,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: AppColors.darkCardBorder, width: 1),
        ),
      ),
      fontFamily: 'sans-serif',
    );
  }
}
