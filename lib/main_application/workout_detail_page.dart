import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatelessWidget {
  final int workoutId;
  final String workoutName;

  WorkoutDetailPage({required this.workoutId, required this.workoutName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Workout: $workoutName',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Workout ID: $workoutId',
              style: TextStyle(fontSize: 16),
            ),
            // Future: Add more workout-specific features here
          ],
        ),
      ),
    );
  }
}
