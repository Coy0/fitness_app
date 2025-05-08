import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/helper_tests/globals.dart';

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
final _data = WorkoutData(); // Add this

List<Map<String, dynamic>> get _workouts => _data.workouts;


  // Add a new workout
  void _addWorkout(String name) {
    setState(() {
      _workouts.add({
        'id': DateTime.now().millisecondsSinceEpoch, // Unique ID for each workout
        'name': name,
        'exercises': [] // Empty list for exercises
      });
    });
  }

  // Edit workout name
  void _editWorkout(int id, String newName) {
    setState(() {
      final workout = _workouts.firstWhere((workout) => workout['id'] == id);
      workout['name'] = newName;
    });
  }

  // Delete workout with confirmation
  void _deleteWorkout(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to delete this workout?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _workouts.removeWhere((workout) => workout['id'] == id);
              });
              Navigator.of(context).pop();
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  // Navigate to Add/Edit Workout screen
Future<void> _navigateToAddWorkout(BuildContext context, {int? workoutId}) async {
  String? initialName;
  if (workoutId != null) {
    final workout = _workouts.firstWhere((w) => w['id'] == workoutId);
    initialName = workout['name'];
  }

  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddEditWorkoutScreen(initialName: initialName),
    ),
  );

  if (result != null) {
    if (workoutId == null) {
      _addWorkout(result); // Add new workout
    } else {
      _editWorkout(workoutId, result); // Edit by ID!
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddWorkout(context),
          ),
          SizedBox(width: 20), // Add some space before the button
        ],
      ),
      body: _workouts.isEmpty
          ? Center(child: Text('No workouts yet. Tap + to add one!'))
          : ListView.builder(
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(workout['name']),
                    onTap: () async {
                      // Navigate to exercise details screen
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailsScreen(workout: workout),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _navigateToAddWorkout(context, workoutId: workout['id']),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteWorkout(workout['id']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}


class AddEditWorkoutScreen extends StatefulWidget {
  final String? initialName;

  AddEditWorkoutScreen({this.initialName});

  @override
  _AddEditWorkoutScreenState createState() => _AddEditWorkoutScreenState();
}

class _AddEditWorkoutScreenState extends State<AddEditWorkoutScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _controller.text = widget.initialName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.initialName == null ? 'Add Workout' : 'Edit Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Workout Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final workoutName = _controller.text.trim();
                if (workoutName.isNotEmpty) {
                  Navigator.pop(context, workoutName);
                }
              },
              child: Text(widget.initialName == null ? 'Add Workout' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> workout;

  ExerciseDetailsScreen({required this.workout});

  @override
  _ExerciseDetailsScreenState createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  List<Map<String, dynamic>> _exercises = [];

  // Add a new exercise
  void _addExercise(String name, int reps, double weight) {
  setState(() {
    final newExercise = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'name': name,
      'reps': reps,
      'weight': weight,
    };
    _exercises.add(newExercise);
    widget.workout['exercises'].add(newExercise); // <-- this keeps the workout updated
  });
}


  @override
void initState() {
  super.initState();
  _exercises = List<Map<String, dynamic>>.from(widget.workout['exercises']);
}


  // Delete exercise with confirmation
 void _deleteExercise(int id) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Are you sure?'),
      content: Text('Do you want to delete this exercise?'),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _exercises.removeWhere((exercise) => exercise['id'] == id);
              widget.workout['exercises'].removeWhere((exercise) => exercise['id'] == id);
            });
            Navigator.of(context).pop();
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.workout['name'])),
      body: _exercises.isEmpty
          ? Center(child: Text('No exercises yet. Tap + to add one!'))
          : ListView.builder(
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('${exercise['name']} - ${exercise['reps']} reps @ ${exercise['weight']} lbs'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteExercise(exercise['id']),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              final repsController = TextEditingController();
              final weightController = TextEditingController();
              return AlertDialog(
                title: Text('Add Exercise'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: nameController, decoration: InputDecoration(labelText: 'Exercise Name')),
                    TextField(controller: repsController, decoration: InputDecoration(labelText: 'Reps'), keyboardType: TextInputType.number),
                    TextField(controller: weightController, decoration: InputDecoration(labelText: 'Weight'), keyboardType: TextInputType.number),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      final name = nameController.text;
                      final reps = int.tryParse(repsController.text) ?? 0;
                      final weight = double.tryParse(weightController.text) ?? 0.0;
                      Navigator.pop(context, {'name': name, 'reps': reps, 'weight': weight});
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
          if (result != null) {
            _addExercise(result['name'], result['reps'], result['weight']);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

