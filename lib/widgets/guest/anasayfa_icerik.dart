import 'package:flutter/material.dart';

// Anasayfa - giriş kısmı
Widget buildPage1() {
  return Container(
    color: Colors.white38,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/pictures/foto1.jpg",
            width: 300,
            height: 300,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Hayalindeki teknoloji kariyerini Tobeto ile başlat.",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Tobeto eğitimlerine katıl, sen de harekete geç, iş hayatında yerini al.",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget buildPage2() {
  return Container(
    color: Colors.white38,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "assets/pictures/foto2.jpg",
            width: 300,
            height: 300,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Tobeto Platform",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                "Eğitim ve istihdam arasında köprü görevi görür.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              Text(" "),
              Text(
                "Eğitim, değerlendirme, istihdam süreçlerinin tek yerden yönetilebileceği dijital platform olarak hem bireylere hem kurumlara hizmet eder.",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    ),
  );
}
