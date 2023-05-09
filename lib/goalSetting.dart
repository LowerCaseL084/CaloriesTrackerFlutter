import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Developer',
      theme: ThemeData(
        // ignore: prefer_const_constructors
        primaryColor: Color(0xFF070A52),
      ),
      home: const MyHomePage(title: 'Goal Setting'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _targetWeight = 55;

  //void _incrementCounter() {setState(() {_counter++;});}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color(0xFF070A52),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF00337C),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Target Weight',
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        )
      ),
    );
  }
}