import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Daftar extends StatefulWidget {
  const Daftar({Key? key}) : super(key: key);

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _daftar() async {
    try {
      final response = await http.post(
        Uri.parse('http://ceklukaid.et.r.appspot.com/daftar'),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Daftar sukses, tambahkan logika sesuai kebutuhan
        print('Daftar sukses');

        // Tampilkan alert pendaftaran berhasil
        _showSuccessAlert();

        // Navigasi ke halaman dashboard
        Navigator.pushNamed(context, '/dashboard');
      } else {
        // Daftar gagal, tambahkan logika sesuai kebutuhan
        print('Daftar gagal: ${response.body}');
        // Tampilkan pesan error kepada pengguna jika diperlukan
      }
    } catch (error) {
      // Tangani error secara umum, tampilkan pesan kesalahan jika diperlukan
      print('Error: $error');
    }
  }

  // Fungsi untuk menampilkan alert pendaftaran berhasil
  void _showSuccessAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pendaftaran Berhasil'),
          content: Text('Akun Anda berhasil didaftarkan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/daftarh.jpg',
              width: 400,
              height: 400,
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat Email',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kata Sandi',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Konfirmasi Kata Sandi',
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              child: Container(
                color: const Color.fromRGBO(228, 116, 116, 1),
                width: 360,
                height: 50,
                child: Center(
                  child: Text("Daftar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              onTap: _daftar,
            ),
          ],
        ),
      ),
    );
  }
}
