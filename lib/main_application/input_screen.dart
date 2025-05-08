// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text(widget.initialText == null ? 'Add Workout' : 'Edit Workout')),
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
                  Navigator.pop(context, workoutName); // Return the input workout name
                }
              },
              child: Text(widget.initialText == null ? 'Add Workout' : 'Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
