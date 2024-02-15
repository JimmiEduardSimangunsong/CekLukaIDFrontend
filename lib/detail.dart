import 'package:flutter/material.dart';
import 'data.dart';

class DetailPages extends StatelessWidget {
  const DetailPages({super.key});

  @override
  Widget build(BuildContext context) {
    final String imagePath =
        ModalRoute.of(context)!.settings.arguments as String;

    // Find the corresponding map in woundImages list based on the image path
    final Map<String, dynamic> woundInfo = woundImages.firstWhere(
      (element) => element['image'] == imagePath,
      orElse: () => {'title': '', 'content': ''},
    );

    final String title = woundInfo['title'];
    final String content = woundInfo['content'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.black.withOpacity(0.6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Luka Sayat: Kenali Batasan $title Ringan Yang Bisa Di Obati Dirumah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width *
                          0.05, // Responsif - Ukuran font sesuai dengan lebar layar
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Batasan: $content',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width *
                          0.04, // Responsif - Ukuran font sesuai dengan lebar layar
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
