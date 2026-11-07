import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const InventarisApp());
}

class InventarisApp extends StatelessWidget {
  const InventarisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris Lab Komputer',

      // Halaman pertama yang ditampilkan adalah LoginPage
      home: const LoginPage(),
    );
  }
}