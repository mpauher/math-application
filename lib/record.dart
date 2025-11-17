import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final _formKey = GlobalKey<FormState>();
  String nombre = '';
  int? tipoId; // cargo
  int? jornadaId; // turno
  bool noTurnoDoble = false;
  bool noDomingo = false;

  List<dynamic> cargos = [];
  List<dynamic> turnos = [];
  bool loading = true;

  Map<String, dynamic>? trabajadorEdicion;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Revisar si recibimos trabajador para edición
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      trabajadorEdicion = args;
      nombre = trabajadorEdicion!['nombre'];
      tipoId = trabajadorEdicion!['id_cargo'];
      jornadaId = trabajadorEdicion!['id_turno'];
      noDomingo = trabajadorEdicion!['no_sabados_domingos'] == 1;
      noTurnoDoble = trabajadorEdicion!['max_5_turnos'] == 1;
    }
  }

  void cargarDatos() async {
    try {
      final cargosData = await ApiService.getCargos();
      final turnosData = await ApiService.getTurnos();
      setState(() {
        cargos = cargosData;
        turnos = turnosData;
        if (tipoId == null && cargos.isNotEmpty) tipoId = cargos[0]['id_cargo'] as int;
        if (jornadaId == null && turnos.isNotEmpty) jornadaId = turnos[0]['id_turno'] as int;
        loading = false;
      });
    } catch (e) {
      print("Error al cargar cargos o turnos: $e");
      setState(() => loading = false);
    }
  }

  void registrarOActualizar() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final payload = {
        'nombre': nombre,
        'id_cargo': tipoId,
        'id_turno': jornadaId, // IMPORTANTE: turno para disponibilidad_semanal
        'no_sabados_domingos': noDomingo ? 1 : 0,
        'max_5_turnos': noTurnoDoble ? 1 : 0,
      };

      if (trabajadorEdicion != null) {
        // Actualizar
        await ApiService.updateTrabajador(trabajadorEdicion!['id_trabajador'], payload);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trabajador actualizado correctamente')),
        );
      } else {
        // Crear
        await ApiService.createTrabajador(payload);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Trabajador registrado correctamente')),
        );
      }

      Navigator.pop(context, true); // regresar a tabla y recargar
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar trabajador')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(trabajadorEdicion != null
              ? 'Editar Trabajador'
              : 'Registrar Trabajador')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Nombre
                TextFormField(
                  initialValue: nombre,
                  decoration: const InputDecoration(
                      labelText: 'Nombre', border: OutlineInputBorder()),
                  onChanged: (value) => nombre = value,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Ingrese un nombre' : null,
                ),
                const SizedBox(height: 16),

                // Cargos
                DropdownButtonFormField<int>(
                  value: tipoId,
                  decoration: const InputDecoration(
                      labelText: 'Cargo', border: OutlineInputBorder()),
                  items: cargos
                      .map((c) => DropdownMenuItem<int>(
                            value: c['id_cargo'] as int,
                            child: Text(c['nombre']),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => tipoId = value),
                ),
                const SizedBox(height: 16),

                // Turnos
                DropdownButtonFormField<int>(
                  value: jornadaId,
                  decoration: const InputDecoration(
                      labelText: 'Turno', border: OutlineInputBorder()),
                  items: turnos
                      .map((t) => DropdownMenuItem<int>(
                            value: t['id_turno'] as int,
                            child: Text(t['nombre']),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => jornadaId = value),
                ),
                const SizedBox(height: 16),

                // Checklist
                CheckboxListTile(
                  title: const Text('No trabajar turno doble'),
                  value: noTurnoDoble,
                  onChanged: (value) => setState(() => noTurnoDoble = value!),
                ),
                CheckboxListTile(
                  title: const Text('No trabajar el domingo'),
                  value: noDomingo,
                  onChanged: (value) => setState(() => noDomingo = value!),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: registrarOActualizar,
                  child: Text(
                      trabajadorEdicion != null ? 'Actualizar' : 'Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
