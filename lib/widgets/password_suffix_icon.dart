import 'package:flutter/material.dart';

class PasswordSuffixIcon extends StatefulWidget {
  const PasswordSuffixIcon({super.key});

  @override
  State<PasswordSuffixIcon> createState() => _PasswordSuffixiconState();
}

class _PasswordSuffixiconState extends State<PasswordSuffixIcon> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibilty() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePasswordVisibilty,
      child: Icon(
        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }
}
