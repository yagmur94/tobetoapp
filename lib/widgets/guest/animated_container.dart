import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Anasayfa - Birlikte Büyüyoruz kısmı

class AnimationControllerExample with ChangeNotifier {
  double _width = 300.0;
  double _height = 300.0;
  Color _color = Colors.purple;
  int _contentIndex = 0;
  Timer? _timer;

  final List<IconData> _icons = [
    FontAwesomeIcons.graduationCap,
    FontAwesomeIcons.book,
    FontAwesomeIcons.laptop
  ];
  final List<String> _texts = [
    "Öğrenci",
    "Asenkron\n Eğitim İçeriği",
    "Saat Canlı Ders",
  ];
  final List<Color> _colors = [
    Colors.purple,
    Colors.blue,
    const Color.fromARGB(255, 88, 231, 165)
  ];
  final List<double> _widths = [250.0, 300.0, 270.0];
  final List<double> _heights = [250.0, 300.0, 270.0];
  final List<int> _numbers = [17600, 8000, 1000];

  double get width => _width;
  double get height => _height;
  Color get color => _color;
  String get text => _texts[_contentIndex];
  IconData get icon => _icons[_contentIndex];
  int get number => _numbers[_contentIndex];

  AnimationControllerExample() {
    _startAutoChange();
  }

  void changeProperties() {
    _contentIndex = (_contentIndex + 1) % _texts.length;
    _width = _widths[_contentIndex];
    _height = _heights[_contentIndex];
    _color = _colors[_contentIndex];
  }

  void _startAutoChange() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      changeProperties();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
