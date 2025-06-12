import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presentación Personal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const PresentacionScreen(),
    );
  }
}

class PresentacionScreen extends StatelessWidget {
  const PresentacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                    child: PersonaCard(
                      nombre: 'Anderson Fernandez',
                      fotoUrl: 'https://i.imgur.com/mVnSHC8.jpeg',
                      github: 'https://github.com/Saixnet021',
                      instagram: 'https://instagram.com/anderszn.svid',
                      twitter: 'https://x.com/saixnet',
                    ),
                  ),
                  SizedBox(height: 20, width: 20),
                  Expanded(
                    child: PersonaCard(
                      nombre: 'Hector Contreras',
                      fotoUrl: 'https://i.imgur.com/MDmeIC3.jpeg',
                      github: 'https://github.com/xhectorcr',
                      instagram: 'https://instagram.com/xhectorcr11',
                      twitter: 'https://twitter.com/xhectorcr',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PersonaCard extends StatelessWidget {
  final String nombre;
  final String fotoUrl;
  final String github;
  final String instagram;
  final String twitter;

  const PersonaCard({
    super.key,
    required this.nombre,
    required this.fotoUrl,
    required this.github,
    required this.instagram,
    required this.twitter,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final double avatarSize = isMobile ? 70 : 100;
    final double padding = isMobile ? 24 : 40;
    final double fontSize = isMobile ? 22 : 32;
    final double iconSize = isMobile ? 24 : 32;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile ? 350 : 500),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.blueAccent],
                  ),
                ),
                padding: const EdgeInsets.all(4),
                child: CircleAvatar(
                  radius: avatarSize,
                  backgroundImage: NetworkImage(fotoUrl),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                nombre,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: iconSize,
                    icon: const FaIcon(FontAwesomeIcons.github),
                    color: Colors.white,
                    onPressed: () => launchURL(github),
                  ),
                  IconButton(
                    iconSize: iconSize,
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    color: Colors.pinkAccent,
                    onPressed: () => launchURL(instagram),
                  ),
                  IconButton(
                    iconSize: iconSize,
                    icon: const FaIcon(FontAwesomeIcons.twitter),
                    color: Colors.lightBlueAccent,
                    onPressed: () => launchURL(twitter),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'No se pudo abrir $url';
  }
}
