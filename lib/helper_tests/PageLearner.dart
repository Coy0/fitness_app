
import 'package:flutter/material.dart';

class LearnerPage extends StatefulWidget {
  @override
  State<LearnerPage> createState() => _LearnerPageState();
}

class _LearnerPageState extends State<LearnerPage> {
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

