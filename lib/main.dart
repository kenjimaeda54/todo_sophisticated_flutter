import 'package:flutter/material.dart';
import 'package:todo_sophisticated/screens/Details.dart';
import 'package:todo_sophisticated/screens/ShowTask.dart';
import 'package:todo_sophisticated/utils/AppRoutes.dart';
import 'package:todo_sophisticated/screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Inter",
      ),
      routes: {
        AppRoutes.home: (_) => HomeScreen(),
        AppRoutes.details: (_) => const Details(),
        AppRoutes.show: (_) => ShowTask(),
      },
    );
  }
}
