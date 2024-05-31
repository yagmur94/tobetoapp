import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EkipCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String title;
  final String linkedInUrl;
  const EkipCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.title,
    required this.linkedInUrl,
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '$url Başlatılamadı..';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(linkedInUrl),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


/*
class EkipList extends StatelessWidget {
  const EkipList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ekip"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          EkipCard(
            imagePath: "assets/ekip/elif.jpeg",
            name: "Elif Kılıç",
            title: "Kurucu Direktör",
            linkedInUrl: 'https://www.linkedin.com/in/eliftugtan/',
          ),
          EkipCard(
            imagePath: "assets/ekip/kader_yavuz.jpg",
            name: "Kader Yavuz",
            title: "Eğitim ve Proje Koordinatörü",
            linkedInUrl: 'https://www.linkedin.com/in/kader-yavuz/',
          ),
          EkipCard(
            imagePath: "assets/ekip/pelin.png",
            name: "Pelin Batır",
            title: "İş Geliştirme ve Yöneticisi",
            linkedInUrl: '',
          ),
          EkipCard(
            imagePath: "assets/ekip/gurkan.jfif",
            name: "Gürkan İlişen",
            title: "Eğitim Teknolojileri ve Platform Sorumlusu",
            linkedInUrl: 'https://www.linkedin.com/in/gürkanilişen/',
          ),
          EkipCard(
            imagePath: "assets/ekip/ali_seyhan.jpg",
            name: "Ali Seyhan",
            title: "Operasyon Uzman Yardımcısı",
            linkedInUrl: 'https://tr.linkedin.com/in/aliseyhnn',
          ),
        ],
      ),
    );
  }
}
*/
