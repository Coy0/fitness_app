import 'package:flutter/material.dart';

class WorkoutDetailPage extends StatefulWidget {
  final int workoutId;
  final String workoutName;

  WorkoutDetailPage({required this.workoutId, required this.workoutName});

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current values
    _nameController.text = widget.workoutName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _repsController,
              decoration: InputDecoration(
                labelText: 'Reps',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // You can save the data locally or in the database here
                final workoutName = _nameController.text;
                final reps = _repsController.text;
                final weight = _weightController.text;

                // Perform any action like saving the data, or simply pop back to previous screen
                Navigator.pop(context, {
                  'workoutId': widget.workoutId,
                  'name': workoutName,
                  'reps': reps,
                  'weight': weight,
                });
              },
              child: Text('Save Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
