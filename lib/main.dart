
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:ceklukaid/masuk.dart';
import 'package:flutter/material.dart';
import 'splash.dart';
import 'daftar.dart';
import 'dashboard.dart';
import 'detail.dart';
import 'artikelkesehatan.dart';
import 'halamanscan.dart';
import 'halamanprofil.dart';
import 'halamanperawatan.dart';
import 'halamanchatbot.dart';


void main() {
  initSocket();
  runApp(const MyApp());

}

initSocket() {
  IO.Socket? socket;
  socket = IO.io("http://10.0.2.2:5000", <String, dynamic>{
    'autoConnect': false,
    'transports': ['websocket'],
  });
  socket.connect();
  socket.onConnect((_) {
    print('Connection established');
    socket?.emit('message', 'test');
  });
  socket.onDisconnect((_) => print('Connection Disconnection'));
  socket.onConnectError((err) => print(err));
  socket.onError((err) => print(err));
  socket.on('message', (data) => print(data));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/detail': (context) => DetailPages(),
        '/masuk': (context) => Masukapp(),
        '/daftar': (context) => Daftar(),
        '/dashboard': (context) => Dashboard(),
        '/artikel_kesehatan_detail': (context) => HealthArticleDetailPage(article: {},),
        '/scan': (context) => ScanPage(),
        '/profil': (context) => ProfilePage(),
        '/perawatan': (context) => PerawatanPage(detectedWound: '',),
        '/chatbot': (context) => ChatbotPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash(),
    );
  }
}

