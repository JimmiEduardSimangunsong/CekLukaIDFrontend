import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PerawatanPage extends StatefulWidget {
  final String detectedWound;
  final String pertanyaan1;
  final String pertanyaan2;

  const PerawatanPage(
      {Key? key,
      required this.detectedWound,
      required this.pertanyaan1,
      required this.pertanyaan2})
      : super(key: key);

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
    try {
      final response = await http.post(
        Uri.parse('http://ceklukaid.et.r.appspot.com/penanganan'),
        body: {
          'predictionText': widget.detectedWound,
          'answerQuestion1': widget.pertanyaan1,
          'answerQuestion2': widget.pertanyaan2,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['penangananawal'];
      } else {
        throw Exception(
            'Failed to load initial treatment. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load initial treatment. Error: $e');
    }
  }

  Future<String> fetchRecommendedMedicine() async {
    try {
      final response = await http.post(
        Uri.parse('http://ceklukaid.et.r.appspot.com/penanganan'),
        body: {
          'predictionText': widget.detectedWound,
          'answerQuestion1': widget.pertanyaan1,
          'answerQuestion2': widget.pertanyaan2,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['rekomendasiobat'];
      } else {
        throw Exception(
            'Failed to load recommended medicine. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load recommended medicine. Error: $e');
    }
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
                  Icon(Icons.healing,
                      size: MediaQuery.of(context).size.width * 0.2,
                      color: Colors
                          .red), // Responsif - Ubah ukuran ikon berdasarkan lebar layar
                ],
              ),
            ),
            TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_services,
                          color: Colors
                              .red), // Tambahkan ikon untuk "Penangan Awal"
                      SizedBox(width: 8),
                      Text('Penangan Awal',
                          style: TextStyle(color: Colors.red, fontSize: 17)),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.local_pharmacy,
                          color: Colors
                              .red), // Tambahkan ikon untuk "Rekomendasi Obat"
                      SizedBox(width: 8),
                      Text('Rekomendasi Obat',
                          style: TextStyle(color: Colors.red, fontSize: 17)),
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
                          child: Text(
                            snapshot.data ?? '',
                            style: TextStyle(fontSize: 17),
                          ),
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
                          child: Text(snapshot.data ?? '',
                              style: TextStyle(fontSize: 17)),
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
        iconSize: MediaQuery.of(context).size.width *
            0.08, // Responsif - Ubah ukuran ikon berdasarkan lebar layar
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            // Navigator.pushNamed(context, '/scan');
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
