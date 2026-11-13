import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Un solo código que se ve como Android o como iOS
/// según la plataforma. Los widgets `.adaptive` eligen el estilo solos.
class AdaptiveDemo extends StatefulWidget {
  const AdaptiveDemo({super.key});

  @override
  State<AdaptiveDemo> createState() => _AdaptiveDemoState();
}

class _AdaptiveDemoState extends State<AdaptiveDemo> {
  // Para la demo forzamos la plataforma; en una app real Flutter la detecta.
  TargetPlatform _plataforma = TargetPlatform.android;
  bool _wifi = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(platform: _plataforma),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Widgets adaptativos')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SegmentedButton<TargetPlatform>(
                segments: const [
                  ButtonSegment(
                    value: TargetPlatform.android,
                    label: Text('Android'),
                    icon: Icon(Icons.android),
                  ),
                  ButtonSegment(
                    value: TargetPlatform.iOS,
                    label: Text('iOS'),
                    icon: Icon(Icons.phone_iphone),
                  ),
                ],
                selected: {_plataforma},
                onSelectionChanged: (s) => setState(() => _plataforma = s.first),
              ),
              const SizedBox(height: 24),
              // Interruptor: Material en Android, Cupertino en iOS.
              SwitchListTile.adaptive(
                title: const Text('Wi-Fi'),
                value: _wifi,
                onChanged: (v) => setState(() => _wifi = v),
              ),
              const SizedBox(height: 24),
              // Indicador de carga: círculo en Android, "ruedita" en iOS.
              const Center(child: CircularProgressIndicator.adaptive()),
              const SizedBox(height: 32),
              Center(
                child: FilledButton(
                  onPressed: () => _mostrarDialogo(context),
                  child: const Text('Mostrar diálogo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mostrarDialogo(BuildContext context) {
    showAdaptiveDialog<void>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: const Text('Mismo código'),
        content: const Text('Este diálogo cambia de estilo según la plataforma.'),
        actions: [_accion(context, 'Entendido')],
      ),
    );
  }

  // En iOS los botones del diálogo deben ser CupertinoDialogAction.
  Widget _accion(BuildContext context, String texto) {
    void cerrar() => Navigator.pop(context);
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoDialogAction(onPressed: cerrar, child: Text(texto))
        : TextButton(onPressed: cerrar, child: Text(texto));
  }
}
