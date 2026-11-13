// Ejemplo nativo de las Human Interface Guidelines con SwiftUI (iOS).
// Misma pantalla que la demo de Flutter: tab bar, título grande,
// lista, alerta de confirmación y ajustes con interruptores.
//
// En iOS 26 estos componentes estándar (tab bar, barras, alertas)
// adoptan Liquid Glass automáticamente, sin cambiar el código.
//
// Uso: crea un proyecto "App" en Xcode y pon NotasView() en el WindowGroup.

import SwiftUI

struct NotasView: View {
    @State private var notas = ["Lista de compras", "Ideas del proyecto", "Parcial de móvil"]
    @State private var notaABorrar: String?

    var body: some View {
        // Navegación principal: tab bar inferior.
        TabView {
            NavigationStack {
                List {
                    ForEach(notas, id: \.self) { nota in
                        Label(nota, systemImage: "doc.text")
                            // Gesto: deslizar la fila para borrar.
                            .swipeActions {
                                Button("Borrar", role: .destructive) { notaABorrar = nota }
                            }
                    }
                }
                .navigationTitle("Notas") // título grande
                .toolbar {
                    Button("Agregar", systemImage: "plus") {
                        notas.append("Nota \(notas.count + 1)")
                    }
                }
                // Alerta de confirmación: el botón destructivo sale en rojo.
                .alert(
                    "¿Borrar la nota?",
                    isPresented: Binding(
                        get: { notaABorrar != nil },
                        set: { if !$0 { notaABorrar = nil } }
                    )
                ) {
                    Button("Borrar", role: .destructive) {
                        notas.removeAll { $0 == notaABorrar }
                    }
                    Button("Cancelar", role: .cancel) {}
                } message: {
                    Text("Esta acción no se puede deshacer.")
                }
            }
            .tabItem { Label("Notas", systemImage: "note.text") }

            AjustesView()
                .tabItem { Label("Ajustes", systemImage: "gearshape") }
        }
        .tint(.orange)
    }
}

struct AjustesView: View {
    @State private var notificaciones = true
    @State private var modoOscuro = false
    @State private var idioma = "Español"

    var body: some View {
        NavigationStack {
            // Form = lista agrupada, como la app Ajustes de iOS.
            Form {
                Section("General") {
                    Toggle("Notificaciones", isOn: $notificaciones)
                    Toggle("Modo oscuro", isOn: $modoOscuro)
                    Picker("Idioma", selection: $idioma) {
                        Text("Español").tag("Español")
                        Text("English").tag("English")
                    }
                }
            }
            .navigationTitle("Ajustes")
        }
    }
}

#Preview {
    NotasView()
}
