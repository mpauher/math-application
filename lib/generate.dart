import 'package:flutter/material.dart';

class GeneratePage extends StatelessWidget {
  const GeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generar Asignación')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Generación de turnos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "Aquí se mostrarán:\n• Progreso\n• Combinaciones analizadas\n• Mejores resultados",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
