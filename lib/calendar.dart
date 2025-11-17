import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  // Convertir fecha 2025-11-17 → Lunes
  String dayNameFromDate(String date) {
    final DateTime parsed = DateTime.parse(date);

    const dias = [
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado",
      "Domingo"
    ];

    // weekday: lunes = 1 ... domingo = 7
    return dias[parsed.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario Semanal')),
      body: FutureBuilder<Map<String, Map<String, List<String>>>>(
        // <-- Cambio aquí: solo traer la última asignación
        future: ApiService.getUltimaAsignacion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final data = snapshot.data ?? {};

          if (data.isEmpty) {
            return const Center(
              child: Text("No hay asignaciones generadas aún"),
            );
          }

          // Convertimos las fechas a nombres de días en orden
          Map<String, Map<String, List<String>>> ordered = {
            'Lunes': {'Mañana': [], 'Tarde': []},
            'Martes': {'Mañana': [], 'Tarde': []},
            'Miércoles': {'Mañana': [], 'Tarde': []},
            'Jueves': {'Mañana': [], 'Tarde': []},
            'Viernes': {'Mañana': [], 'Tarde': []},
            'Sábado': {'Mañana': [], 'Tarde': []},
            'Domingo': {'Mañana': [], 'Tarde': []},
          };

          data.forEach((fecha, turnos) {
            final dayName = dayNameFromDate(fecha);
            ordered[dayName] = {
              "Mañana": List<String>.from(turnos["mañana"] ?? turnos["Mañana"] ?? []),
              "Tarde": List<String>.from(turnos["tarde"] ?? turnos["Tarde"] ?? []),
            };
          });

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: ordered.entries.expand((entry) {
                  final day = entry.key;
                  final shifts = entry.value;

                  return shifts.entries.map((shiftEntry) {
                    final shift = shiftEntry.key;
                    final workers = shiftEntry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$day - $shift',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          workers.isEmpty
                              ? const Text("No hay trabajadores asignados")
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: workers
                                      .map((w) => Text("• $w"))
                                      .toList(),
                                ),
                        ],
                      ),
                    );
                  });
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}