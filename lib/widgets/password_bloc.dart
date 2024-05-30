import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';

enum CustomPasswordStrength implements PasswordStrengthItem {
  weak,
  medium,
  strong;

  @override
  Color get statusColor {
    switch (this) {
      case CustomPasswordStrength.weak:
        return Colors.red;
      case CustomPasswordStrength.medium:
        return Colors.orange;
      case CustomPasswordStrength.strong:
        return Colors.green;
    }
  }

  @override
  Widget? get statusWidget {
    switch (this) {
      case CustomPasswordStrength.weak:
        return const Text("Şifre Zayıf");
      case CustomPasswordStrength.medium:
        return const Text("Şifre Orta");
      case CustomPasswordStrength.strong:
        return const Text("Şifre Güçlü");
      default:
        return const Text("Şifre Belirlenemiyor");
    }
  }

  @override
  double get widthPerc {
    switch (this) {
      case CustomPasswordStrength.weak:
        return 0.15;
      case CustomPasswordStrength.medium:
        return 0.4;
      case CustomPasswordStrength.strong:
        return 0.75;
      default:
        return 0.0;
    }
  }

  static CustomPasswordStrength? calculate({required String password}) {
    if (password.isEmpty) {
      return null;
    }
    if (commonDictionary[password] == true) {
      return CustomPasswordStrength.weak;
    }
    if (password.length < 6 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[a-z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password) ||
        !RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return CustomPasswordStrength.weak;
    } else if (RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return CustomPasswordStrength.strong;
    } else {
      return CustomPasswordStrength.medium;
    }
  }
}
