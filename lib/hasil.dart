import 'package:flutter/material.dart';
import 'dart:io';

class ResultPage extends StatefulWidget {
  final File imageFile;

  ResultPage({required this.imageFile});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int _currentIndex = 1; // Set initial index to 1 for "Scan" tab
  String? woundType = '';
  String? answerQuestion1;
  String? answerQuestion2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Prediksi'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Image.file(
                  widget.imageFile,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Jenis Luka: $woundType', // Display the predicted wound type
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      woundType = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Ini Prediksi',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Question 1
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pertanyaan 1: Apakah ada material yang tertinggal?'),
                    DropdownButton<String>(
                      value: answerQuestion1,
                      items: <String>['Iya', 'Tidak'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          answerQuestion1 = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Question 2
              Container(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pertanyaan 2: Apakah material berkarat?'),
                    DropdownButton<String>(
                      value: answerQuestion2,
                      items: <String>['Iya', 'Tidak'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          answerQuestion2 = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Add more questions based on the wound type
              ElevatedButton(
                onPressed: () {
                  // TODO: Handle action when the "Selanjutnya" button is pressed
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Ganti warna tombol sesuai keinginan
                ),
                child: Text('Selanjutnya'),
              ),
            ],
          ),
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
            // Navigator.pushNamed(context, '/scan'); // No need to navigate again
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