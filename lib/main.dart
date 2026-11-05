import 'package:flutter/material.dart';
import 'pages/profile_page.dart'; // Import halaman utama profil
import 'services/pref_service.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized(); //sajib sebelum await di main
  final prefs = await PrefService.init();
  await prefs.increaseOpenCount();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final PrefService prefs;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Profile Card',
      debugShowCheckedModeBanner: false,
      home: ProfilePage(prefs: prefs), // Memanggil halaman ProfilePage dari lib/pages/profile_page.dart
    );
  }
}