import 'package:flutter/material.dart';

class InputArea extends StatelessWidget {
  final TextEditingController controller;
  final String lebelText;

  final FormFieldValidator<String>? validator;

  const InputArea({
    required this.controller,
    this.validator,
    required this.lebelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(lebelText),
          hintText: lebelText,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0))),
      validator: validator,
    );
  }
}
