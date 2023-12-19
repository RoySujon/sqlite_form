import 'package:flutter/material.dart';

class CustomeTextFieldForm extends StatelessWidget {
  const CustomeTextFieldForm({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.validator,
  });
  final TextEditingController controller;
  final String? hintText;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            prefixIcon: Icon(suffixIcon)),
      ),
    );
  }
}
