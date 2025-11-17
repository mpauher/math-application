import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8001/api";

  // Método de prueba
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

  // GET /api/trabajadores
  static Future<List<dynamic>> getTrabajadores() async {
    final url = Uri.parse("$baseUrl/trabajadores");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    } else {
      throw Exception("Error al cargar trabajadores: ${response.statusCode}");
    }
  }

    // Traer cargos
  static Future<List<dynamic>> getCargos() async {
    final response = await http.get(Uri.parse("$baseUrl/cargos"));
    if (response.statusCode == 200) {
      return List<dynamic>.from(json.decode(response.body));
    }
    throw Exception('Error al traer cargos');
  }

  // Traer turnos
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
    if (response.statusCode != 200) throw Exception('Error al actualizar trabajador: ${response.body}');
  }

  // Eliminar trabajador
  static Future<void> deleteTrabajador(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/trabajadores/$id"));
    if (response.statusCode != 200) throw Exception('Error al eliminar trabajador');
  }
}
