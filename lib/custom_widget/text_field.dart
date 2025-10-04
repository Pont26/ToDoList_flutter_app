import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
    final ValueChanged<String>? onChanged; // <-- callback for GetX


  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false, // default = normal text
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 69, 69, 69),
        ),
      ),
    );
  }
}
