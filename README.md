# Principios de diseño de interfaces móviles: Material Design vs. Human Interface Guidelines

Ejemplos de código de la exposición de **Programación Móvil**.

**Integrantes:** Vanessa Orozco · Daniel Castañeda

La misma app de notas está construida tres veces en Flutter para comparar las dos guías de diseño:

| Demo | Guía | Qué muestra |
| --- | --- | --- |
| `material_demo.dart` | Material Design 3 (Google / Android) | `AppBar`, `NavigationBar`, botón flotante (FAB), `Card`, `AlertDialog`, `SnackBar`, `SwitchListTile` |
| `cupertino_demo.dart` | Human Interface Guidelines (Apple / iOS) | `CupertinoTabBar`, título grande, listas agrupadas, `CupertinoSwitch`, `CupertinoAlertDialog`, `CupertinoActionSheet` |
| `adaptive_demo.dart` | Ambas | Widgets `.adaptive`: un solo código que se ve como Android o como iOS |

En la carpeta `nativo/` está la misma pantalla en código nativo, como referencia:

- `nativo/android-compose/NotasScreen.kt`: Material 3 con **Jetpack Compose** (Kotlin).
- `nativo/ios-swiftui/NotasView.swift`: HIG con **SwiftUI** (Swift). En iOS 26 sus componentes estándar adoptan Liquid Glass automáticamente.

## Cómo ejecutarlo

Requisitos: [Flutter](https://docs.flutter.dev/get-started/install) 3.24 o superior.

```bash
git clone https://github.com/Vanessaorozco/diseno-interfaces-moviles.git
cd diseno-interfaces-moviles

# Genera las carpetas de plataforma (android, ios, web...) sin tocar lib/
flutter create . --project-name diseno_interfaces_moviles

flutter pub get
flutter run            # en un emulador o celular conectado
flutter run -d chrome  # o en el navegador
```

## Estructura

```
lib/
├── main.dart                  # MaterialApp con tema Material 3 (color semilla)
└── screens/
    ├── home_screen.dart       # Menú para elegir la demo
    ├── material_demo.dart     # Material Design 3
    ├── cupertino_demo.dart    # Human Interface Guidelines (Cupertino)
    └── adaptive_demo.dart     # Widgets adaptativos
nativo/
├── android-compose/NotasScreen.kt
└── ios-swiftui/NotasView.swift
```

## Comparación rápida

| Elemento | Material (Flutter) | Cupertino (Flutter) |
| --- | --- | --- |
| Navegación principal | `NavigationBar` | `CupertinoTabBar` |
| Acción principal | `FloatingActionButton` | Botón `+` en la barra superior |
| Título | `AppBar` | `CupertinoSliverNavigationBar` (título grande) |
| Diálogo | `AlertDialog` | `CupertinoAlertDialog` |
| Menú de opciones | `BottomSheet` | `CupertinoActionSheet` |
| Interruptor | `Switch` / `SwitchListTile` | `CupertinoSwitch` |
| Lista de ajustes | `ListTile` | `CupertinoListSection.insetGrouped` |

> Nota: los widgets Cupertino de Flutter reproducen el estilo clásico de iOS. Liquid Glass (iOS 26) solo se obtiene hoy con SwiftUI/UIKit nativo.

## Referencias

- [Material Design 3](https://m3.material.io/)
- [Material 3 Expressive (Android Developers)](https://developer.android.com/design/ui/wear/guides/get-started/apply)
- [Human Interface Guidelines (Apple)](https://developer.apple.com/design/human-interface-guidelines/)
- [Adopting Liquid Glass (Apple)](https://developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass)
- [Flutter: widgets Material](https://docs.flutter.dev/ui/widgets/material) · [widgets Cupertino](https://docs.flutter.dev/ui/widgets/cupertino)
