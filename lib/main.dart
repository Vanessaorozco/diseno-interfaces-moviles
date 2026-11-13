import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() => runApp(const DisenoApp());

class DisenoApp extends StatelessWidget {
  const DisenoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material vs HIG',
      debugShowCheckedModeBanner: false,
      // Material 3: toda la paleta se genera a partir de un solo color semilla.
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF3D6FE0),
      ),
      home: const HomeScreen(),
    );
  }
}
