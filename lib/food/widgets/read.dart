import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Read extends StatefulWidget {
  final Map<String, dynamic> nutrients;
  Read({Key? key, required this.nutrients}) : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }

  addCounter(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int energy = widget.nutrients['energy'] ?? 0;  // Example of accessing energy directly
    setState(() {
      counter += energy;
      prefs.setInt('counter', counter);
    });

    Navigator.pop(context);
  }

  @override
