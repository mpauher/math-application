import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final _formKey = GlobalKey<FormState>();

  // Campos del formulario
  String nombre = '';
  String tipo = 'Supervisor';
  String horario = 'Mañana';
  bool noTurnoDoble = false;
  bool noDomingo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Trabajador')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        nombre = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Desplegable 
                  DropdownButtonFormField<String>(
                    initialValue: tipo,
                    decoration: const InputDecoration(
                      labelText: 'Tipo',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Supervisor', child: Text('Supervisor')),
                      DropdownMenuItem(value: 'Operario', child: Text('Operario')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        tipo = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Desplegable 
                  DropdownButtonFormField<String>(
                    initialValue: horario,
                    decoration: const InputDecoration(
                      labelText: 'Horario',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Mañana', child: Text('Mañana')),
                      DropdownMenuItem(value: 'Tarde', child: Text('Tarde')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        horario = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Checklist
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        title: const Text('No trabajar turno doble'),
                        value: noTurnoDoble,
                        onChanged: (value) {
                          setState(() {
                            noTurnoDoble = value!;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text('No trabajar el domingo'),
                        value: noDomingo,
                        onChanged: (value) {
                          setState(() {
                            noDomingo = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botón Registrar
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        
                        Navigator.pushNamed(context, '/table');
                      }
                    },
                    child: const Text('Registrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
