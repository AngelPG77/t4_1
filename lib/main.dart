
import 'package:flutter/material.dart';
import 'package:t4_1/views/ResumenPedido.dart';
import 'package:t4_1/views/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 105, 155)),
      ),
      home: const HomePage(), 
      routes: {
        '/resumenPedido': (context) => const ResumenPedido(),
      },
    );
  }
}