import 'package:flutter/material.dart';
import 'workers.dart';
import 'shifts.dart';
import 'rules.dart';
import 'generate.dart';
import 'hello_test.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organizador y optimizador'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                "Bienvenido",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WorkersPage()),
                    );
                  },
                  child: const Text("Trabajadores"),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ShiftsPage()),
                    );
                  },
                  child: const Text("Turnos"),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RulesPage()),
                    );
                  },
                  child: const Text("Restricciones"),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GeneratePage()),
                    );
                  },
                  child: const Text("Generar Asignación"),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 220,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HelloTestPage()),
                    );
                  },
                  child: const Text("Probar API"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
