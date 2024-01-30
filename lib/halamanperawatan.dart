import 'package:flutter/material.dart';

class PerawatanPage extends StatefulWidget {
  final String detectedWound;

  const PerawatanPage({Key? key, required this.detectedWound}) : super(key: key);

  @override
  State<PerawatanPage> createState() => _PerawatanPageState();
}

class _PerawatanPageState extends State<PerawatanPage> {
  int _currentIndex = 1; // Set initial index to 1 for "Scan" tab
  late Future<String> initialTreatment;
  late Future<String> recommendedMedicine;

  @override
  void initState() {
    super.initState();
    initialTreatment = fetchInitialTreatment();
    recommendedMedicine = fetchRecommendedMedicine();
  }

  Future<String> fetchInitialTreatment() async {
    // Ganti URL API untuk penanganan awal sesuai kebutuhan
    // Misalnya: https://example.com/api/initial-treatment?woundType=${widget.detectedWound}
    // Implementasikan logika panggilan API sesuai kebutuhan aplikasi
    // Contoh sederhana:
    await Future.delayed(Duration(seconds: 2)); // Simulasi panggilan API
    return 'Ini adalah penanganan awal untuk ${widget.detectedWound}';
  }

  Future<String> fetchRecommendedMedicine() async {
    // Ganti URL API untuk rekomendasi obat sesuai kebutuhan
    // Misalnya: https://example.com/api/recommended-medicine?woundType=${widget.detectedWound}
    // Implementasikan logika panggilan API sesuai kebutuhan aplikasi
    // Contoh sederhana:
    await Future.delayed(Duration(seconds: 2)); // Simulasi panggilan API
    return 'Ini adalah rekomendasi obat untuk ${widget.detectedWound}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perawatan Luka Mu'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Nama Luka: ${widget.detectedWound}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Icon(Icons.healing, size: 40, color: Colors.red), // Tambahkan ikon luka
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_services, color: Colors.red), // Tambahkan ikon untuk "Penangan Awal"
                      SizedBox(width: 8),
                      Text('Penangan Awal', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_pharmacy, color: Colors.red), // Tambahkan ikon untuk "Rekomendasi Obat"
                      SizedBox(width: 8),
                      Text('Rekomendasi Obat', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<String>(
                    future: initialTreatment,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Text(snapshot.data ?? ''),
                        );
                      }
                    },
                  ),
                  FutureBuilder<String>(
                    future: recommendedMedicine,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Text(snapshot.data ?? ''),
                        );
                      }
                    },
                  ),
                ],
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
            // Navigator.pushNamed(context, '/scan');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/profil');
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
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}