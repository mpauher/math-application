import 'package:flutter/material.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Turnos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Configuración de turnos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Definir Turnos por Día"),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Personas Necesarias por Turno"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
