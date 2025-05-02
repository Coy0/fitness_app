
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to the input screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Press the + icon to add'),
      ),
    );
  }
}

class InputScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Name')),
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
                // Handle the input value
                print('User entered: ${_controller.text}');
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}