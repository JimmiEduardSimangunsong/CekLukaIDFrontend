import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Masukapp extends StatefulWidget {
  const Masukapp({super.key});

  @override
  State<Masukapp> createState() => _MasukappState();
}

class _MasukappState extends State<Masukapp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.97.90:3000/masuk'), // Menggunakan URL API yang benar
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Login sukses, tambahkan logika sesuai kebutuhan
        print('Login sukses');

        // Tampilkan AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Berhasil'),
              content: Text('Selamat datang! Anda berhasil login.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Pindah ke halaman dashboard setelah menutup AlertDialog
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Login gagal, tambahkan logika sesuai kebutuhan
        print('Login gagal: ${response.body}');
        // Tampilkan pesan error kepada pengguna jika diperlukan
      }
    } catch (error) {
      // Tangani error secara umum, tampilkan pesan kesalahan jika diperlukan
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/masuk.jpg',
              width: MediaQuery.of(context).size.width *
                  0.8, // Responsif - 80% dari lebar layar
              height: MediaQuery.of(context).size.width *
                  0.8, // Responsif - 80% dari lebar layar
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
            InkWell(
              child: Container(
                color: const Color.fromRGBO(228, 116, 116, 1),
                width: MediaQuery.of(context).size.width *
                    0.8, // Responsif - 80% dari lebar layar
                height: 50,
                child: Center(
                  child: Text("Masuk",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              onTap: _login,
            ),
          ],
        ),
      ),
    );
  }
}
