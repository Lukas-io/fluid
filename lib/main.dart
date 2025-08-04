import 'package:fluid/screens/home_screen.dart';
import 'package:fluid/core/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluid',
      debugShowCheckedModeBanner: false,
      //TODO: REMOVE THIS (TURN IT TO FALSE, MAKES YOUR POST MORE BELEIVEABLE)
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}
