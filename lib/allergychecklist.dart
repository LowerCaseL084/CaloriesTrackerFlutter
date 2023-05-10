import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: const Color.fromARGB(255, 7, 9, 82),
      )),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 7, 9, 82),
        appBar: AppBar(
          title: const Text(
            'Allergies',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          elevation: 0,
        ),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('Milk',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      activeColor: Colors.white,
      checkColor: const Color.fromARGB(255, 7, 9, 82),
      value: timeDilation != 1.0,
      onChanged: (bool? value) {
        setState(() {
          timeDilation = value! ? 10.0 : 1.0;
        });
      },
    );
  }
}
