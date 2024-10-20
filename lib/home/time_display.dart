import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDisplay extends StatefulWidget {
  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  String currentTime = '';
  String currentDay = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Update the time initially
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      //currentYear = DateFormat.YYYY.format(now);
      currentTime = DateFormat.jm().format(now); // e.g., 10:30 AM
      currentDay = DateFormat.EEEE().format(now); // e.g., Saturday
    });
    // Call this method again after 1 second
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          currentDay,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        Text(
          currentTime,
          style: const TextStyle(fontSize: 16, color: Colors.pink),
        ),
      ],
    );
  }
}
