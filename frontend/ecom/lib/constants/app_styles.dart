import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final heading = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final subheading = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.black54,
  );

  static final linkText = GoogleFonts.poppins(
    color: Colors.blueAccent,
    fontWeight: FontWeight.w500,
  );

  static final buttonText = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
  );

  static InputDecoration inputDecoration(String label, Icon icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
