import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'login.dart';
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: Colors.white,
      onInit: () {
        debugPrint("On Init");
      },
      onEnd: () {
        debugPrint("On End");
      },
      childWidget: SizedBox(
        height: 400,
        width: 400,
        child: Image.asset("assets/Red Minimalist Hospital Doctor Logo.png"),
      ),
      duration: const Duration(milliseconds: 3000),
      onAnimationEnd: () => debugPrint("On Fade In End"),
      nextScreen: const Masuk(),
    );
  }
}
