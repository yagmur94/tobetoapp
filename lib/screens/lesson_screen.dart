//appbar; ders adı/favorilere ekle/kaydet

//body (column); 
//cw1: x tarihine kadar bitirebilirsin & %x tamamlandı barı
//cw2: ilgili ders videosu
//cw2: içerik(default)/hakkında/katılımcılar

//içerik: video listesi
//hakkında: başlangıç ve bitiş tarihleri/tahmini süre/eğitim türü/eğitim/kategori/seviye/üretici firma/açıklama
//katılımcılar: katılımcı listesi ve ad/soyad filtre araması

//*hakkında kısmı ders detay sayfasındaki cw2 ile birleştirilebilir*

import 'package:flutter/material.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Ders Adı'),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                // Favorilere ekleme işlemi
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {
                // Kaydetme işlemi
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Tamamlanma Durumu ve Tarih Bilgisi
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bu dersi 30 Haziran 2024 tarihine kadar bitirebilirsin',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                LinearProgressIndicator(value: 0.4), // %40 tamamlandı
                SizedBox(height: 5),
                Text(
                  '%40 Tamamlandı',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Ders Videosu
          Container(
            color: Colors.grey,
            height: 200,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Ders Videosu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          // İçerik/Hakkında/Katılımcılar Sekmeleri
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [selectedIndex == 0, selectedIndex == 1, selectedIndex == 2],
              onPressed: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('İçerik'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Hakkında'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Katılımcılar'),
                ),
              ],
            ),
          ),
          // Seçili Sekmeye Göre İçeriğin Gösterimi
          Expanded(
            child: selectedIndex == 0
                ? ListView(
                    children: const [
                      ListTile(title: Text('Video 1')),
                      ListTile(title: Text('Video 2')),
                      ListTile(title: Text('Video 3')),
                    ],
                  )
                : selectedIndex == 1
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Başlangıç Tarihi: 1 Ocak 2024'),
                            Text('Bitiş Tarihi: 30 Haziran 2024'),
                            Text('Tahmini Süre: 6 ay'),
                            Text('Eğitim Türü: Online'),
                            Text('Eğitim: Flutter Geliştirme'),
                            Text('Kategori: Yazılım'),
                            Text('Seviye: Başlangıç'),
                            Text('Üretici Firma: Tobeto'),
                            Text(
                              'Açıklama: Bu eğitim, Flutter ile mobil uygulama geliştirme konusunda temel bilgileri içermektedir.',
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: const [
                          ListTile(title: Text('Katılımcı 1')),
                          ListTile(title: Text('Katılımcı 2')),
                          ListTile(title: Text('Katılımcı 3')),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}