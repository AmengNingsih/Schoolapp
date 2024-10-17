import 'package:flutter/material.dart';
import 'splash.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.green, // Mengubah warna tema menjadi hijau
        // Anda dapat menyesuaikan tampilan lebih lanjut di sini
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
