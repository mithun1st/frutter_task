import 'package:flutter/material.dart';

class NumTextField extends StatelessWidget {
  final Function fnc;
  final String label;
  final String hint;
  final String defaultValue;

  const NumTextField({
    super.key,
    required this.fnc,
    required this.label,
    required this.hint,
    required this.defaultValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: defaultValue),
      onChanged: (v) {
        fnc(v);
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.onetwothree),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
