import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artikelkesehatan.dart';
import 'data.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(228, 116, 116, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Tengah-tengah vertikal
                crossAxisAlignment: CrossAxisAlignment.center, // Tengah-tengah horizontal
                children: [
                  Text(
                    'Selamat Datang Di CekLukaID🙌',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center, // Pusatkan teks
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Temukan Kemudahan Dalam Mendeteksi dan Merawat Luka Mu',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    textAlign: TextAlign.center, // Pusatkan teks
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
                  textStyle:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 200,
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
                      width: MediaQuery.of(context).size.width *
                          0.4, // Responsif - 40% dari lebar layar
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
                  textStyle:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: healthArticles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthArticleDetailPage(
                              article: healthArticles[index]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width *
                          0.7, // Responsif - 70% dari lebar layar
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
                          padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          color: Colors.black54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                healthArticles[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
        ],
      ),
    );
  }
}
