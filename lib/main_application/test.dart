// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TestRunner extends StatefulWidget {
  @override
  State<TestRunner> createState() => _TestRunnerState();
}

class _TestRunnerState extends State<TestRunner> {

final TextEditingController workoutBox = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Text Example',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This list will store the user inputs
  List<String> _userInputs = [];

  // Function to handle when the user submits text from the input screen
  void _addInput(String input) {
    setState(() {
      _userInputs.add(input);
    });
  }

  // Function to handle editing an input
  void _editInput(int index, String newInput) {
    setState(() {
      _userInputs[index] = newInput;
    });
  }

  // Function to handle deleting an input
  void _deleteInput(int index) {
    setState(() {
      _userInputs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navigate to the input screen and wait for the result
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InputScreen()),
              );
              if (result != null) {
                _addInput(result); // Add the result to the list
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _userInputs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(_userInputs[index]),
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
                              InputScreen(initialText: _userInputs[index]),
                        ),
                      );
                      if (editedText != null) {
                        _editInput(index, editedText); // Edit the input
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteInput(index); // Delete the input
                    },
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
