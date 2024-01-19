import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Masuk extends StatefulWidget {
  const Masuk({super.key});

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(
            'assets/login.jpg',
            width: 400,
            height: 400,
          ),
          const SizedBox(height: 20,),
          Column(
            children: [
              InkWell(
                child:Container(
                  color: const Color.fromRGBO(228, 116, 116,1),
                  width: 380,
                  height: 50,
                  child:Center(
                      child: Text("Masuk",style: GoogleFonts.poppins(textStyle:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),)
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/masuk');
                },
              ),
              const SizedBox(height: 20,),
              InkWell(
                child: Container(
                    width: 380,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                    child: Center(
                        child : Text("Daftar",style: GoogleFonts.poppins(textStyle:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),)
                    )
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/daftar');
                },
              )
            ]
          )
        ],
      )

        );
  }
}
