import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onChanged;
  final IconData iconName;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  ReusableTextFormField({
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.iconName,
    this.obscureText = false,
    required this.keyboardType,
    required this.validator,
     this.maxLines=1
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText:obscureText ,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.inversePrimary)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.inversePrimary)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.inversePrimary)),
          prefixIcon: Icon(iconName)),
         maxLines: maxLines,
         minLines: 1,
    );
  }
}
