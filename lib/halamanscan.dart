import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'hasil.dart';
import 'kamera.dart'; // Import halaman kamera

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  int _currentIndex = 1;
  late File _pickedFile;

  @override
  void initState() {
    super.initState();
    _pickedFile = File('assets/phone.jpg'); // Ganti dengan path gambar default Anda
  }

  Future<void> _getImageFromCamera() async {
    final pickedImage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraPage(),
      ),
    );

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

  Future<void> _getImage(ImageSource source) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/login.jpg', // Ganti dengan path logo aplikasi Anda
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              'Ayo Cek Luka Mu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _getImageFromCamera(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Kamera'),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
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
            // Stay on the current page (ScanPage)
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
