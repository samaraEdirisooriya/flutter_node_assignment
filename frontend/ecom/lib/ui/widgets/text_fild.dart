import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      validator: validator,
    );
  }
}
