import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("SchedulePage")),
    );
  }
}