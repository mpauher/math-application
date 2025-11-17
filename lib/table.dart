import 'package:flutter/material.dart';

class TableScreen extends StatelessWidget {
  final List<Map<String, String>> workers = [
    {'nombre': 'Juan', 'cargo': 'Operario'},
    {'nombre': 'María', 'cargo': 'Supervisor'},
    {'nombre': 'Pedro', 'cargo': 'Operario'},
  ];

  TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tabla de Trabajadores')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];
                return ListTile(
                  title: Text(worker['nombre']!),
                  subtitle: Text(worker['cargo']!),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Acción Editar
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Acción Borrar
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/record'),
                  child: Text('Agregar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  child: Text('Inicio'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
