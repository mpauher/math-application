import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Ajusta la ruta según tu proyecto

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<dynamic> workers = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    cargarTrabajadores();
  }

  void cargarTrabajadores() async {
    try {
      final data = await ApiService.getTrabajadores();
      setState(() {
        workers = data;
        loading = false;
      });
    } catch (e) {
      print("Error al cargar trabajadores: $e");
      setState(() => loading = false);
    }
  }

  void eliminarTrabajador(int id) async {
    try {
      await ApiService.deleteTrabajador(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Trabajador eliminado')),
      );
      cargarTrabajadores(); // recargar la tabla
    } catch (e) {
      print("Error al eliminar trabajador: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar trabajador')),
      );
    }
  }

  void editarTrabajador(Map<String, dynamic> trabajador) async {
    // Navegar a RecordScreen en modo edición
    final result = await Navigator.pushNamed(
      context,
      '/record',
      arguments: trabajador, // pasamos los datos para prellenar el formulario
    );
    if (result == true) {
      cargarTrabajadores(); // recargar la tabla si hubo cambios
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tabla de Trabajadores')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];
                return ListTile(
                  title: Text(worker['nombre']),
                  subtitle: Text(worker['cargo']['nombre']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => editarTrabajador(worker),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => eliminarTrabajador(worker['id_trabajador']),
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
                  child: const Text('Agregar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  child: const Text('Inicio'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
