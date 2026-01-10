import 'package:flutter/material.dart';

import 'app/modules/main_layout/main_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Admin',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MainLayout(),
    );
  }
}
