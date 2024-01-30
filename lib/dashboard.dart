import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artikelkesehatan.dart';
import 'data.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
  // final List<String> woundImages = [
  //   'assets/sayat.jpg',
  //   'assets/gores.jpeg',
  //   'assets/tusuk.jpg',
  //   // Add more wound images from your assets folder
  // ];
//   final List<Map<String, dynamic>> healthArticles = [
//     {
//       'title': 'Mengenal Jenis Luka dan Cara Merawatnya',
//       'image': 'assets/ibu.jpeg',
//       'sumber': 'Alodokter',
//       'content': 'Artikel ini membahas berbagai jenis luka dan cara merawatnya...',
//     },
//     {
//       'title': 'Langkah-langkah Merawat Luka di Rumah',
//       'image': 'assets/articledua.jpg',
//       'sumber': 'Alodokter',
//       'content': 'Ingin tahu cara merawat luka di rumah? Simak informasinya di sini...',
//     },
// ];
    // Add more health articles as needed
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 500,
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(228, 116, 116, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang Di CekLukaID🙌',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Temukan Kemudahan Dalam Mendeteksi dan Merawat Luka Mu',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Luka Ringan Seperti Apa yang Bisa Ditangani Secara Mandiri?',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: woundImages.length,
              itemBuilder: (context, index) {
                String woundName = woundImages[index]['title'];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: woundImages[index]['image'],
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(woundImages[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        color: Colors.black54,
                        child: Center(
                          child: Text(
                            woundName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Artikel Kesehatan',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: healthArticles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HealthArticleDetailPage(article: healthArticles[index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8),
                    width: 250, // Adjusted width for larger size
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(healthArticles[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        color: Colors.black54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              color: Colors.black54,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    healthArticles[index]['title'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16, // Adjusted font size
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Sumber: ${healthArticles[index]['sumber']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        iconSize: 35,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/scan');
          } else if (index == 2) {
            // Update the navigation to the chatbot screen
            Navigator.pushNamed(context, '/chatbot');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat), // Change the icon to a chat icon
            label: 'Chatbot', // Change the label to 'Chatbot'
          ),
        ],
      ),
    );
  }
}


