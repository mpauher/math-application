import 'package:flutter/material.dart';
import 'workers.dart';
import 'record.dart';
import 'table.dart';
import 'calendar.dart';
import 'hello_test.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Gestión',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/workers': (context) => WorkersScreen(),
        '/record': (context) => RecordScreen(),
        '/table': (context) => TableScreen(),
        '/calendar': (context) => CalendarScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
 
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/workers'),
              child: Text('Trabajadores'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse("http://127.0.0.1:8001/api/asignaciones/generar");

                try {
                  final response = await http.post(url);

                  print("STATUS: ${response.statusCode}");
                  print("BODY: ${response.body}");

                  if (response.statusCode == 200 || response.statusCode == 201) {
                    Navigator.pushNamed(context, '/calendar');
                  } else {
                    print("Error al generar asignaciones: ${response.body}");
                  }
                } catch (e) {
                  print("Error de conexión: $e");
                }
              },
              child: Text('Asignación'),
            ),


            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HelloTestPage()),
                );
              },
              child: Text('Probar API'),
            ),            
          ],
        ),
      ),
    );
  }
}
