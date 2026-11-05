import 'package:flutter/material.dart';
import 'pages/profile_page.dart'; // Import halaman utama profil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(), // Memanggil halaman ProfilePage dari lib/pages/profile_page.dart
    );
  }
}