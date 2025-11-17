import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8001/api";

  // HELLO TEST
  static Future<String> getHello() async {
    final url = Uri.parse("$baseUrl/hello");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  // GET trabajadores
  static Future<List<dynamic>> getTrabajadores() async {
    final url = Uri.parse("$baseUrl/trabajadores");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    } else {
      throw Exception("Error al cargar trabajadores: ${response.statusCode}");
    }
  }

  // GET cargos
  static Future<List<dynamic>> getCargos() async {
    final response = await http.get(Uri.parse("$baseUrl/cargos"));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    }
    throw Exception('Error al traer cargos');
  }

  // GET turnos
  static Future<List<dynamic>> getTurnos() async {
    final response = await http.get(Uri.parse("$baseUrl/turnos"));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    }
    throw Exception('Error al traer turnos');
  }

  // Crear trabajador
  static Future<void> createTrabajador(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/trabajadores"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear trabajador: ${response.body}');
    }
  }

  // Actualizar trabajador
  static Future<void> updateTrabajador(int id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("$baseUrl/trabajadores/$id"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar trabajador: ${response.body}');
    }
  }

  // Eliminar trabajador
  static Future<void> deleteTrabajador(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/trabajadores/$id")
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar trabajador');
    }
  }

  // ============================
  //   ASIGNACIONES (CALENDARIO)
  // ============================

  /// GET /api/asignaciones/semana
  static Future<Map<String, Map<String, List<String>>>> getAsignaciones() async {
    final url = Uri.parse("$baseUrl/asignaciones/semana");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      final Map<String, Map<String, List<String>>> parsed = {};

      decoded.forEach((day, shifts) {
        parsed[day] = {
          "Mañana": List<String>.from(shifts["Mañana"] ?? []),
          "Tarde": List<String>.from(shifts["Tarde"] ?? []),
        };
      });

      return parsed;
    } else {
      throw Exception("Error al obtener asignaciones: ${response.statusCode}");
    }
  }

  /// POST /api/asignaciones/generar
  static Future<Map<String, dynamic>> generarSemana(String fechaInicio) async {
    final url = Uri.parse("$baseUrl/asignaciones/generar");

    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"fecha_inicio": fechaInicio}),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("Error al generar asignaciones: ${res.body}");
    }
  }

  static Future<Map<String, Map<String, List<String>>>> getUltimaAsignacion() async {
  final url = Uri.parse("$baseUrl/asignaciones/ultima");
  final res = await http.get(url);

  if (res.statusCode == 200) {
    final decoded = json.decode(res.body);
    final Map<String, Map<String, List<String>>> parsed = {};

    decoded.forEach((fecha, turnos) {
      parsed[fecha] = {
        "Mañana": List<String>.from(turnos["mañana"] ?? []),
        "Tarde": List<String>.from(turnos["tarde"] ?? [])
      };
    });

    return parsed;
  } else {
    throw Exception("Error al obtener asignaciones: ${res.body}");
  }
}

}