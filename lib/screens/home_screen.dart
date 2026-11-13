import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_demo.dart';
import 'cupertino_demo.dart';
import 'material_demo.dart';

/// Pantalla inicial: elige qué guía de diseño quieres ver.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diseño de interfaces móviles')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DemoCard(
            titulo: 'Material Design',
            subtitulo: 'Google · Android',
            icono: Icons.android,
            color: const Color(0xFF3D6FE0),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MaterialDemo()),
            ),
          ),
          const SizedBox(height: 12),
          _DemoCard(
            titulo: 'Human Interface Guidelines',
            subtitulo: 'Apple · iOS (widgets Cupertino)',
            icono: Icons.phone_iphone,
            color: const Color(0xFFE8892B),
            onTap: () => Navigator.of(context).push(
              CupertinoPageRoute(builder: (_) => const CupertinoDemo()),
            ),
          ),
          const SizedBox(height: 12),
          _DemoCard(
            titulo: 'Widgets adaptativos',
            subtitulo: 'Un solo código, dos estilos',
            icono: Icons.devices,
            color: const Color(0xFF2E8B73),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AdaptiveDemo()),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: color,
          foregroundColor: Colors.white,
          child: Icon(icono),
        ),
        title: Text(titulo),
        subtitle: Text(subtitulo),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
