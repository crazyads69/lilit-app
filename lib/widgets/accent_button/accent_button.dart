import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilit/app_theme.dart';

class AccentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AccentButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
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
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
