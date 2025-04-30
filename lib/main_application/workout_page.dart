
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
 @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Text-Display",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

