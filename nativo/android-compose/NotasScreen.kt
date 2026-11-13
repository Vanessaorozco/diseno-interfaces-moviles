// Ejemplo nativo de Material Design 3 con Jetpack Compose (Android).
// Misma pantalla que la demo de Flutter: barra superior, FAB,
// barra de navegación inferior, lista y diálogo de confirmación.
//
// Uso: crea un proyecto "Empty Activity" en Android Studio y llama
// NotasScreen() dentro de setContent { MaterialTheme { ... } }.

package com.ejemplo.diseno

import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExtendedFloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ListItem
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun NotasScreen() {
    var tab by remember { mutableIntStateOf(0) }
    var notaABorrar by remember { mutableStateOf<String?>(null) }
    val notas = remember {
        mutableStateListOf("Lista de compras", "Ideas del proyecto", "Parcial de móvil")
    }

    Scaffold(
        topBar = { TopAppBar(title = { Text("Notas") }) },
        // Acción principal: botón flotante.
        floatingActionButton = {
            ExtendedFloatingActionButton(
                onClick = { notas.add("Nota ${notas.size + 1}") },
                icon = { Icon(Icons.Default.Add, contentDescription = null) },
                text = { Text("Nueva nota") },
            )
        },
        // Navegación principal: barra inferior.
        bottomBar = {
            NavigationBar {
                NavigationBarItem(
                    selected = tab == 0,
                    onClick = { tab = 0 },
                    icon = { Icon(Icons.Default.Home, contentDescription = null) },
                    label = { Text("Notas") },
                )
                NavigationBarItem(
                    selected = tab == 1,
                    onClick = { tab = 1 },
                    icon = { Icon(Icons.Default.Settings, contentDescription = null) },
                    label = { Text("Ajustes") },
                )
            }
        },
    ) { padding ->
        LazyColumn(contentPadding = padding) {
            items(notas) { nota ->
                ListItem(
                    headlineContent = { Text(nota) },
                    trailingContent = {
                        IconButton(onClick = { notaABorrar = nota }) {
                            Icon(Icons.Default.Delete, contentDescription = "Borrar")
                        }
                    },
                )
            }
        }
    }

    // Diálogo de confirmación de Material 3.
    notaABorrar?.let { nota ->
        AlertDialog(
            onDismissRequest = { notaABorrar = null },
            title = { Text("¿Borrar la nota?") },
            text = { Text("Esta acción no se puede deshacer.") },
            confirmButton = {
                TextButton(onClick = { notas.remove(nota); notaABorrar = null }) {
                    Text("Borrar")
                }
            },
            dismissButton = {
                TextButton(onClick = { notaABorrar = null }) { Text("Cancelar") }
            },
        )
    }
}
