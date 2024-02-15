import 'package:flutter/material.dart';

class HealthArticleDetailPage extends StatelessWidget {
  final Map<String, dynamic> article;
  const HealthArticleDetailPage({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title'] ?? 'Detail Artikel Kesehatan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  0.4, // Responsif - Set tinggi gambar berdasarkan tinggi layar
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(article['image'] ?? 'assets/article1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    article['title'] ?? 'Judul Artikel',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight
                            .bold), // Responsif - Set ukuran font berdasarkan lebar layar
                  ),
                  SizedBox(height: 8),
                  Text(
                    'sumber: ${article['sumber'] ?? 'Tidak diketahui'}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors
                            .grey), // Responsif - Set ukuran font berdasarkan lebar layar
                  ),
                  SizedBox(height: 16),
                  Text(
                    article['content'] ?? 'Tidak ada konten yang tersedia.',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *
                            0.04), // Responsif - Set ukuran font berdasarkan lebar layar
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
