import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Se llenara con la API que hizo Pau
    final Map<String, Map<String, List<String>>> calendarData = {
      'Lunes': {'Mañana': [], 'Tarde': []},
      'Martes': {'Mañana': [], 'Tarde': []},
      'Miércoles': {'Mañana': [], 'Tarde': []},
      'Jueves': {'Mañana': [], 'Tarde': []},
      'Viernes': {'Mañana': [], 'Tarde': []},
      'Sábado': {'Mañana': [], 'Tarde': []},
      'Domingo': {'Mañana': [], 'Tarde': []},
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Calendario')),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // lista de días y turnos
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: calendarData.entries.expand((entry) {
                      final day = entry.key;
                      final shifts = entry.value;
                      return shifts.entries.map((shiftEntry) {
                        final shift = shiftEntry.key;
                        final workers = shiftEntry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$day - $shift',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              if (workers.isEmpty)
                                const Text('No hay trabajadores asignados')
                              else
                                ...workers.map((w) => Text('• $w')),
                            ],
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // regresar al main
                    },
                    child: const Text('Inicio'),
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
