import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final Function fnc;
  final String label;
  final String hint;
  final int minLen;
  final int maxLen;
  final String defaultValue;

  NameTextField({
    super.key,
    required this.fnc,
    required this.label,
    required this.hint,
    required this.minLen,
    required this.maxLen,
    required this.defaultValue,
  });

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = defaultValue;
    return TextField(
      controller: _controller,
      onChanged: (v) {
        if (v.length > maxLen) {
          _controller.text = v.substring(0, maxLen);
          return;
        }
        fnc(v);
      },
      minLines: minLen,
      maxLines: maxLen,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.abc),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: TextInputType.name,
    );
  }
}
