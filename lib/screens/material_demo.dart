import 'package:flutter/material.dart';

/// Ejemplo de Material Design 3:
/// AppBar, NavigationBar inferior, botón flotante (FAB), tarjetas,
/// diálogo (AlertDialog), SnackBar e interruptores (SwitchListTile).
class MaterialDemo extends StatefulWidget {
  const MaterialDemo({super.key});

  @override
  State<MaterialDemo> createState() => _MaterialDemoState();
}

class _MaterialDemoState extends State<MaterialDemo> {
  int _tab = 0;
  bool _notificaciones = true;
  bool _modoOscuro = false;
  final List<String> _notas = [
    'Lista de compras',
    'Ideas del proyecto',
    'Parcial de móvil',
  ];

  Future<void> _confirmarBorrado(String nota) async {
    final borrar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: const Text('¿Borrar la nota?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (borrar != true || !mounted) return;
    setState(() => _notas.remove(nota));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$nota" borrada')),
    );
  }

  void _nuevaNota() {
    setState(() => _notas.add('Nota ${_notas.length + 1}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tab == 0 ? 'Notas' : 'Ajustes')),
      body: _tab == 0 ? _buildNotas() : _buildAjustes(),
      // Acción principal de la pantalla: botón flotante.
      floatingActionButton: _tab == 0
          ? FloatingActionButton.extended(
              onPressed: _nuevaNota,
              icon: const Icon(Icons.add),
              label: const Text('Nueva nota'),
            )
          : null,
      // Navegación principal: barra inferior de Material 3.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.sticky_note_2_outlined),
            selectedIcon: Icon(Icons.sticky_note_2),
            label: 'Notas',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }

  Widget _buildNotas() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: _notas.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final nota = _notas[i];
        // Card: superficie elevada; la sombra indica qué está "encima".
        return Card(
          child: ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(nota),
            subtitle: const Text('Toca el ícono para borrar'),
            trailing: IconButton(
              tooltip: 'Borrar',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _confirmarBorrado(nota),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAjustes() {
    return ListView(
      children: [
        SwitchListTile(
          secondary: const Icon(Icons.notifications_outlined),
          title: const Text('Notificaciones'),
          value: _notificaciones,
          onChanged: (v) => setState(() => _notificaciones = v),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.dark_mode_outlined),
          title: const Text('Modo oscuro'),
          value: _modoOscuro,
          onChanged: (v) => setState(() => _modoOscuro = v),
        ),
        const ListTile(
          leading: Icon(Icons.language),
          title: Text('Idioma'),
          subtitle: Text('Español'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
