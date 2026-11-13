import 'dart:ui' show Brightness;

import 'package:flutter/cupertino.dart';

/// Ejemplo de las Human Interface Guidelines con widgets Cupertino:
/// tab bar inferior, título grande, listas agrupadas, interruptores,
/// alerta (CupertinoAlertDialog) y hoja de acciones (CupertinoActionSheet).
class CupertinoDemo extends StatelessWidget {
  const CupertinoDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemOrange,
      ),
      // Navegación principal: tab bar inferior.
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.doc_text),
              label: 'Notas',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.gear),
              label: 'Ajustes',
            ),
          ],
        ),
        tabBuilder: (context, index) => CupertinoTabView(
          builder: (context) =>
              index == 0 ? const _NotasPage() : const _AjustesPage(),
        ),
      ),
    );
  }
}

/// Botón "atrás" para volver al menú inicial de la app.
Widget _botonVolver(BuildContext context) {
  return CupertinoNavigationBarBackButton(
    previousPageTitle: 'Inicio',
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  );
}

class _NotasPage extends StatefulWidget {
  const _NotasPage();

  @override
  State<_NotasPage> createState() => _NotasPageState();
}

class _NotasPageState extends State<_NotasPage> {
  final List<String> _notas = [
    'Lista de compras',
    'Ideas del proyecto',
    'Parcial de móvil',
  ];

  Future<void> _confirmarBorrado(String nota) async {
    final borrar = await showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('¿Borrar la nota?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true, // texto en rojo
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (borrar == true && mounted) setState(() => _notas.remove(nota));
  }

  // Hoja de acciones: sube desde abajo, cerca del pulgar.
  void _mostrarOpciones() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Crear'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _notas.add('Nota ${_notas.length + 1}'));
            },
            child: const Text('Nueva nota'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Nueva lista'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          // Título grande que se encoge al hacer scroll.
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Notas'),
            leading: _botonVolver(context),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _mostrarOpciones,
              child: const Icon(CupertinoIcons.add),
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              header: const Text('Toca una nota para borrarla'),
              children: [
                for (final nota in _notas)
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.doc_text),
                    title: Text(nota),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () => _confirmarBorrado(nota),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AjustesPage extends StatefulWidget {
  const _AjustesPage();

  @override
  State<_AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<_AjustesPage> {
  bool _notificaciones = true;
  bool _modoOscuro = false;

  // Ícono con fondo de color, como en la app Ajustes de iOS.
  Widget _icono(IconData icono, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icono, color: CupertinoColors.white, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Ajustes'),
        leading: _botonVolver(context),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('GENERAL'),
              children: [
                CupertinoListTile(
                  leading: _icono(CupertinoIcons.bell_fill,
                      CupertinoColors.systemRed),
                  title: const Text('Notificaciones'),
                  trailing: CupertinoSwitch(
                    value: _notificaciones,
                    onChanged: (v) => setState(() => _notificaciones = v),
                  ),
                ),
                CupertinoListTile(
                  leading: _icono(CupertinoIcons.moon_fill,
                      CupertinoColors.systemIndigo),
                  title: const Text('Modo oscuro'),
                  trailing: CupertinoSwitch(
                    value: _modoOscuro,
                    onChanged: (v) => setState(() => _modoOscuro = v),
                  ),
                ),
                CupertinoListTile(
                  leading: _icono(CupertinoIcons.globe,
                      CupertinoColors.systemBlue),
                  title: const Text('Idioma'),
                  additionalInfo: const Text('Español'),
                  trailing: const CupertinoListTileChevron(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
