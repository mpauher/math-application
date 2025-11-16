import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restricciones')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Restricciones globales",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Máximo de turnos por persona"),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Tiempo mínimo de descanso"),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Evitar turnos consecutivos"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
