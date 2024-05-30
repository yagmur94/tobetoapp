import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFooter extends StatelessWidget {
  const CommonFooter({super.key});

  final String facebookUrl = 'https://www.facebook.com/tobetoplatform/';
  final String instagramUrl = 'https://www.instagram.com/tobeto_official/';
  final String xUrl = 'https://x.com/tobeto_platform';
  final String linkedinUrl = 'https://tr.linkedin.com/company/tobeto';

  /*
 class LauncherUtil {
    static Future<void> launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if(!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        trow '$url Başlatılamadı..';
      }
    }
  }
  */

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '$url Başlatılamadı..';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20.0),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: Color.fromARGB(255, 163, 77, 233), width: 2.0),
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: 130.0,
          child: Image.asset(
            'assets/logo/tobetologo.PNG',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20.0),
        const Text(
          "© 2024 Tobeto I Her Hakkı Saklıdır.",
          style: TextStyle(fontSize: 13),
        ),
        const SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _launchUrl(facebookUrl),
              icon: const FaIcon(FontAwesomeIcons.facebook),
              color: const Color.fromARGB(255, 163, 77, 233),
            ),
            IconButton(
              onPressed: () => _launchUrl(xUrl),
              icon: const FaIcon(FontAwesomeIcons.twitter),
              color: const Color.fromARGB(255, 163, 77, 233),
            ),
            IconButton(
              onPressed: () => _launchUrl(instagramUrl),
              icon: const FaIcon(FontAwesomeIcons.instagram),
              color: const Color.fromARGB(255, 163, 77, 233),
            ),
            IconButton(
              onPressed: () => _launchUrl(linkedinUrl),
              icon: const FaIcon(FontAwesomeIcons.linkedin),
              color: const Color.fromARGB(255, 163, 77, 233),
            ),
          ],
        ),
      ],
    );
  }
}
