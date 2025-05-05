import 'package:flutter/material.dart';

class WorkoutExercisePage extends StatefulWidget {
  final Map<String, dynamic> workout; // Pass the selected workout to this page

  WorkoutExercisePage({required this.workout});

  @override
  _WorkoutExercisePageState createState() => _WorkoutExercisePageState();
}

class _WorkoutExercisePageState extends State<WorkoutExercisePage> {
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  void _addExercise() {
    final exerciseName = _exerciseController.text.trim();
    final reps = int.tryParse(_repsController.text.trim()) ?? 0;
    final weight = double.tryParse(_weightController.text.trim()) ?? 0.0;

    if (exerciseName.isNotEmpty && reps > 0 && weight > 0) {
      setState(() {
        // Add the new exercise to the workout's exercise list
        widget.workout['exercises'].add({
          'name': exerciseName,
          'reps': reps,
          'weight': weight,
        });
      });

      // Clear the input fields
      _exerciseController.clear();
      _repsController.clear();
      _weightController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.workout['name']} Exercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _exerciseController,
              decoration: InputDecoration(labelText: 'Exercise Name'),
            ),
            TextField(
              controller: _repsController,
              decoration: InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addExercise,
              child: Text('Add Exercise'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.workout['exercises'].length,
                itemBuilder: (context, index) {
                  final exercise = widget.workout['exercises'][index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(exercise['name']),
                      subtitle: Text('Reps: ${exercise['reps']} | Weight: ${exercise['weight']} kg'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
