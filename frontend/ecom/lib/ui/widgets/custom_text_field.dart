import 'package:flutter/material.dart';
import '../../constants/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: AppStyles.inputDecoration(label, icon),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
