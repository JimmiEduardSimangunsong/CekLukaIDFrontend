import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'hasil.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int _currentIndex = 1; // Set initial index to 1 for "Scan" tab
  late File _pickedFile;

  Future _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _pickedFile = File(pickedImage.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(imageFile: _pickedFile),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pickedFile = File('assets/phone.jpg'); // Replace with your custom image path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayo Cek Luka Mu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your App Logo
            Image.asset(
              'assets/login.jpg', // Replace with your app logo path
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            // Title
            Text(
              'Ayo Cek Luka Mu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Camera and Gallery Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Change to your desired button color
                  ),
                  child: Text('Kamera'),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Change to your desired button color
                  ),
                  child: Text('Galeri'),
                ),
              ],
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