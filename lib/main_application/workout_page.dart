
import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/main_application/workout_detail_page.dart';
import 'package:first_mobile_app_test1/helper_tests/database_helper.dart';

class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

final TextEditingController workoutBox = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Text Example',
      home: HomeScreen(accountId: 2,),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int accountId; // Declare accountId
  HomeScreen({required this.accountId}); // Accept accountId as a parameter

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _workouts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  // Fetch workouts from the database for the specific accountId
  Future<void> _loadWorkouts() async {
    final workouts = await getWorkouts(widget.accountId);
    setState(() {
      _workouts = workouts;
      _isLoading = false;
    });
  }

  // Edit a workout's name
  Future<void> _editWorkout(int workoutId, String newName) async {
    try {
      await updateWorkoutName(workoutId, newName); // Update in DB
      _loadWorkouts(); // Reload workouts
    } catch (e) {
      print('Error updating workout: $e');
    }
  }

  // Delete a workout
  Future<void> _deleteWorkout(int workoutId) async {
    try {
      await deleteWorkout(workoutId); // Delete from DB
      _loadWorkouts(); // Reload workouts
    } catch (e) {
      print('Error deleting workout: $e');
    }
  }

  // Add a new workout/input
  void _addInput(String input) {
    setState(() {
      _workouts.add({
        'id': DateTime.now().millisecondsSinceEpoch, // Simulated ID
        'name': input,
      });
    });
    insertWorkout(input, widget.accountId);  // Pass accountId when inserting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputScreen()),
              );
              if (result != null) {
                _addInput(result); // Add input
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_workouts.isEmpty
              ? Center(child: Text('No workouts yet. Tap + to add one!'))
              : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (context, index) {
                    final workout = _workouts[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(workout['name']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutDetailPage(
                                workoutId: workout['id'],
                                workoutName: workout['name'],
                              ),
                            ),
                          );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                final editedText = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InputScreen(initialText: workout['name']),
                                  ),
                                );
                                if (editedText != null) {
                                  _editWorkout(workout['id'], editedText);
                                }
                              },
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
                )),
    );
  }
}



class InputScreen extends StatefulWidget {
  final String? initialText;
  InputScreen({this.initialText});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // If initialText is provided (for editing), set it in the controller
    if (widget.initialText != null) {
      _controller.text = widget.initialText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.initialText == null ? 'Add Item' : 'Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter something'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final inputText = _controller.text.trim();
                if (inputText.isNotEmpty) {
                  Navigator.pop(context, inputText); // Return the input text
                }
              },
              child: Text(widget.initialText == null ? 'Add' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}


