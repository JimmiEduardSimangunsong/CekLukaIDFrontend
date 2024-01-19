import 'package:flutter/material.dart';

class Daftar extends StatefulWidget {
  const Daftar({super.key});

  @override
  State<Daftar> createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            Image.asset(
              'assets/daftarh.jpg',
              width: 400,
              height: 400,
            ),
const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal:20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Alamat Email',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal:20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kata Sandi',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal:20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Konfirmasi Kata Sandi',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              child:Container(
                color: const Color.fromRGBO(228, 116, 116,1),
                width: 360,
                height: 50,
                child:Center(
                    child: Text("Daftar",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
          ]
        )
      )
    );
  }
}
