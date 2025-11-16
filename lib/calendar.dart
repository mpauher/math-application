import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario Final')),
      body: const Center(
        child: Text(
          "Aquí se mostrará el calendario final\ncon los turnos asignados.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
