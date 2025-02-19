import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Constants for reuse across the theme to improve maintainability.
class AppConstants {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusSmall = 8.0;
  static const double buttonHeight = 48.0;
  static const double cardElevation = 2.0;
  static const EdgeInsets contentPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  static const double iconSize = 24.0;
}

class AppColors {
  // Accent Color: Granary Gold
  static const Color accent = Color(0xFFFAAD14);

  static const MaterialColor accentSwatch = MaterialColor(
    0xFFFAAD14,
    <int, Color>{
      50: Color(0xFFFFF7E6),
      100: Color(0xFFFFEFCC),
      200: Color(0xFFFFE7B3),
      300: Color(0xFFFFDF99),
      400: Color(0xFFFFD780),
      500: Color(0xFFFAAD14),
      600: Color(0xFFE69B00),
      700: Color(0xFFCC8800),
      800: Color(0xFFB37600),
      900: Color(0xFF995C00),
    },
  );

  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF1890FF);
  static const Color neutral100 = Color(0xFFF5F6F7);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);
  static const Color neutralDark = Color(0xFF171717);
  // Neutral Colors
  static const Color neutralLight = Color(0xFFF5F6F7);

  // Primary Color: Apocyan
  static const Color primary = Color(0xFF60A6F8);

  static const MaterialColor primarySwatch = MaterialColor(
    0xFF60A6F8,
    <int, Color>{
      50: Color(0xFFE6F0FE),
      100: Color(0xFFCDE1FD),
      200: Color(0xFFB4D2FC),
      300: Color(0xFF98C4FA),
      400: Color(0xFF7AB3F9),
      500: Color(0xFF60A6F8),
      600: Color(0xFF4497F7),
      700: Color(0xFF2888F6),
      800: Color(0xFF0C79F5),
      900: Color(0xFF0958D9),
    },
  );

  // Status Colors
  static const Color success = Color(0xFF52C41A);

  static const Color warning = Color(0xFFFAAD14);
}

class AppTheme {
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primarySwatch[300]!,
      primaryColorDark: AppColors.primarySwatch[700]!,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primarySwatch[600]!,
        secondary: AppColors.accent,
        secondaryContainer: AppColors.accentSwatch[600]!,
        surface: Colors.white,
        surfaceContainerHighest: AppColors.neutralLight,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: AppColors.neutralDark,
        onSurfaceVariant: AppColors.neutralDark,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.neutralLight,
      cardColor: Colors.white,
      dividerColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      splashColor: Colors.grey.withValues(alpha: 26),
      unselectedWidgetColor: Colors.grey[500],
      disabledColor: Colors.grey[400],
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primarySwatch[600],
        foregroundColor: AppColors.neutral100,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
        elevation: 8,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      inputDecorationTheme: _buildInputDecorationTheme(isLight: true),
      elevatedButtonTheme: _buildElevatedButtonTheme(isLight: true),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isLight: true),
      textButtonTheme: _buildTextButtonTheme(isLight: true),
      switchTheme: _buildSwitchTheme(isLight: true),
      checkboxTheme: _buildCheckboxTheme(isLight: true),
      radioTheme: _buildRadioTheme(isLight: true),
      sliderTheme: _buildSliderTheme(isLight: true),
      tabBarTheme: _buildTabBarTheme(isLight: true),
      chipTheme: _buildChipTheme(isLight: true),
      dialogTheme: _buildDialogTheme(isLight: true),
      bottomSheetTheme: _buildBottomSheetTheme(isLight: true),
      snackBarTheme: _buildSnackBarTheme(isLight: true),
      tooltipTheme: _buildTooltipTheme(isLight: true),
      cardTheme: _buildCardTheme(isLight: true),
      popupMenuTheme: _buildPopupMenuTheme(isLight: true),
      iconTheme: IconThemeData(
          color: AppColors.neutral600, size: AppConstants.iconSize),
      primaryIconTheme:
          IconThemeData(color: AppColors.primary, size: AppConstants.iconSize),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: Colors.grey[200],
        circularTrackColor: Colors.grey[200],
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primarySwatch[300]!,
      primaryColorDark: AppColors.primarySwatch[700]!,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primarySwatch[600]!,
        secondary: AppColors.accent,
        secondaryContainer: AppColors.accentSwatch[600]!,
        surface: AppColors.neutralDark,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.neutralDark,
      cardColor: Color(0xFF1F1F1F),
      dividerColor: Colors.grey[800],
      highlightColor: Colors.grey[800],
      splashColor: Colors.white.withValues(alpha: 26),
      disabledColor: Colors.grey[700],
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: AppBarTheme(
        color: AppColors.primarySwatch[600],
        foregroundColor: AppColors.neutral100,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: Color(0xFF1A1A1A),
        elevation: 8,
      ),
      textTheme: _buildTextTheme(base.textTheme, isDark: true),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, isDark: true),
      inputDecorationTheme: _buildInputDecorationTheme(isLight: false),
      elevatedButtonTheme: _buildElevatedButtonTheme(isLight: false),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isLight: false),
      textButtonTheme: _buildTextButtonTheme(isLight: false),
      switchTheme: _buildSwitchTheme(isLight: false),
      checkboxTheme: _buildCheckboxTheme(isLight: false),
      radioTheme: _buildRadioTheme(isLight: false),
      sliderTheme: _buildSliderTheme(isLight: false),
      tabBarTheme: _buildTabBarTheme(isLight: false),
      chipTheme: _buildChipTheme(isLight: false),
      dialogTheme: _buildDialogTheme(isLight: false),
      bottomSheetTheme: _buildBottomSheetTheme(isLight: false),
      snackBarTheme: _buildSnackBarTheme(isLight: false),
      tooltipTheme: _buildTooltipTheme(isLight: false),
      cardTheme: _buildCardTheme(isLight: false),
      popupMenuTheme: _buildPopupMenuTheme(isLight: false),
      iconTheme: IconThemeData(
          color: AppColors.neutral600, size: AppConstants.iconSize),
      primaryIconTheme:
          IconThemeData(color: AppColors.primary, size: AppConstants.iconSize),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: Colors.grey[800],
        circularTrackColor: Colors.grey[800],
      ),
    );
  }

  static TextStyle codeStyle(BuildContext context) {
    return GoogleFonts.firaCode(
      textStyle: TextStyle(
        fontSize: 14,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, {bool isDark = false}) {
    Color textColor = isDark ? Colors.white : Colors.black;
    return base.copyWith(
      displayLarge: GoogleFonts.inter(
        textStyle: base.displayLarge,
        fontSize: 96,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
        color: textColor,
      ),
      displayMedium: GoogleFonts.inter(
        textStyle: base.displayMedium,
        fontSize: 60,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: textColor,
      ),
      displaySmall: GoogleFonts.inter(
        textStyle: base.displaySmall,
        fontSize: 48,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.inter(
        textStyle: base.headlineLarge,
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.inter(
        textStyle: base.headlineMedium,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.inter(
        textStyle: base.headlineSmall,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleMedium: GoogleFonts.inter(
        textStyle: base.titleMedium,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: GoogleFonts.inter(
        textStyle: base.titleSmall,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.inter(
        textStyle: base.bodyLarge,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        textStyle: base.bodyMedium,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      labelLarge: GoogleFonts.inter(
        textStyle: base.labelLarge,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
        color: textColor,
      ),
      bodySmall: GoogleFonts.inter(
        textStyle: base.bodySmall,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textColor,
      ),
      labelSmall: GoogleFonts.inter(
        textStyle: base.labelSmall,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
        color: textColor,
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(
      {required bool isLight}) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isLight ? Colors.grey[100] : Colors.grey[900],
      contentPadding: AppConstants.contentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        borderSide:
            BorderSide(color: isLight ? Colors.grey[300]! : Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        borderSide: BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        borderSide: BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle:
          TextStyle(color: isLight ? Colors.grey[700] : Colors.grey[300]),
      hintStyle:
          TextStyle(color: isLight ? Colors.grey[500] : Colors.grey[500]),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
      {required bool isLight}) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.neutral100,
        padding: AppConstants.contentPadding,
        minimumSize: Size(88, AppConstants.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
      {required bool isLight}) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primarySwatch[600],
        side: BorderSide(color: AppColors.primary),
        padding: AppConstants.contentPadding,
        minimumSize: Size(88, AppConstants.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme({required bool isLight}) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: AppConstants.contentPadding,
        minimumSize: Size(88, AppConstants.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
        textStyle: TextStyle(
          fontFamily: GoogleFonts.inter().fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static SwitchThemeData _buildSwitchTheme({required bool isLight}) {
    return SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey[400]! : Colors.grey[700]!;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return isLight ? Colors.grey[50]! : Colors.grey[400]!;
      }),
      trackColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey[300]! : Colors.grey[800]!;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary.withValues(alpha: 128);
        }
        return isLight ? Colors.grey[300]! : Colors.grey[700]!;
      }),
    );
  }

  static CheckboxThemeData _buildCheckboxTheme({required bool isLight}) {
    return CheckboxThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey[400]! : Colors.grey[700]!;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return isLight ? Colors.grey[50]! : Colors.grey[400]!;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static RadioThemeData _buildRadioTheme({required bool isLight}) {
    return RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey[400]! : Colors.grey[700]!;
        }
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }
        return isLight ? Colors.grey[50]! : Colors.grey[400]!;
      }),
    );
  }

  static SliderThemeData _buildSliderTheme({required bool isLight}) {
    return SliderThemeData(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: isLight ? Colors.grey[300] : Colors.grey[700],
      thumbColor: AppColors.primary,
      overlayColor: AppColors.primary.withValues(alpha: 51), // 0.2 * 255 ≈ 51
      valueIndicatorColor: AppColors.primary,
      valueIndicatorTextStyle: TextStyle(color: Colors.white),
    );
  }

  static TabBarTheme _buildTabBarTheme({required bool isLight}) {
    return TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      labelColor: AppColors.primary,
      unselectedLabelColor: isLight ? Colors.grey[700] : Colors.grey[400],
      labelStyle: TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
    );
  }

  static ChipThemeData _buildChipTheme({required bool isLight}) {
    return ChipThemeData(
      backgroundColor: isLight ? Colors.grey[200] : Colors.grey[800],
      disabledColor: isLight ? Colors.grey[300] : Colors.grey[700],
      selectedColor: AppColors.primary,
      secondarySelectedColor: AppColors.accent,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      labelStyle: TextStyle(color: isLight ? Colors.black87 : Colors.white),
      secondaryLabelStyle: TextStyle(color: Colors.white),
      brightness: isLight ? Brightness.light : Brightness.dark,
    );
  }

  static DialogTheme _buildDialogTheme({required bool isLight}) {
    return DialogTheme(
      backgroundColor: isLight ? Colors.white : Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge)),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: isLight ? AppColors.neutralDark : Colors.white,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 16,
        color: isLight ? Colors.grey[800] : Colors.grey[300],
      ),
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme({required bool isLight}) {
    return BottomSheetThemeData(
      backgroundColor: isLight ? Colors.white : Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.borderRadiusLarge)),
      ),
    );
  }

  static SnackBarThemeData _buildSnackBarTheme({required bool isLight}) {
    return SnackBarThemeData(
      backgroundColor: isLight ? AppColors.neutralDark : Colors.grey[900],
      contentTextStyle: GoogleFonts.inter(color: Colors.white),
      actionTextColor: AppColors.accent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall)),
      behavior: SnackBarBehavior.floating,
    );
  }

  static TooltipThemeData _buildTooltipTheme({required bool isLight}) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: isLight
            ? AppColors.neutralDark.withValues(alpha: 230)
            : Colors.grey[800]!.withValues(alpha: 230),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
      ),
      textStyle: GoogleFonts.inter(color: Colors.white),
    );
  }

  static CardTheme _buildCardTheme({required bool isLight}) {
    return CardTheme(
      color: isLight ? Colors.white : AppColors.neutralDark,
      shadowColor: isLight
          ? Colors.black.withValues(alpha: 26) // 0.1 * 255 ≈ 26
          : Colors.black.withValues(alpha: 77), // 0.3 * 255 ≈ 77
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        side: BorderSide(
          color: isLight ? AppColors.neutral300 : AppColors.neutral600,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    );
  }

  static PopupMenuThemeData _buildPopupMenuTheme({required bool isLight}) {
    return PopupMenuThemeData(
      color: isLight ? Colors.white : Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall)),
      elevation: 4,
      textStyle: GoogleFonts.inter(
          color: isLight ? AppColors.neutralDark : Colors.white),
    );
  }
}
