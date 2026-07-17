import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int maxLine;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLine=1,
    this.isPassword=false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      maxLines: maxLine,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon!=null ? Icon(prefixIcon): null,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      ),
    );
  }
}
