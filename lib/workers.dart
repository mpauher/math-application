import 'package:flutter/material.dart';

class WorkersPage extends StatelessWidget {
  const WorkersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trabajadores')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Gestión de trabajadores",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Añadir Trabajador"),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Ver Lista de Trabajadores"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
