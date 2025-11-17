import 'package:flutter/material.dart';
import 'services/api_service.dart';

class HelloTestPage extends StatefulWidget {
  const HelloTestPage({super.key});

  @override
  State<HelloTestPage> createState() => _HelloTestPageState();
}

class _HelloTestPageState extends State<HelloTestPage> {
  String mensaje = "Presiona el botón";

  void probarApi() async {
    final resp = await ApiService.getHello();
    setState(() {
      mensaje = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prueba Laravel API")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensaje),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: probarApi,
              child: const Text("Probar conexión"),
            ),
          ],
        ),
      ),
    );
  }
}
