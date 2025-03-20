import 'package:flutter/material.dart';


class ChangeImageTest extends StatefulWidget {
  @override

  // ignore: library_private_types_in_public_api
  _TestLoginState createState() => _TestLoginState();
}

/// This creates a controler for the username and password text fields
/// to allow for the text to be stored and displayed on the screen
class _TestLoginState extends State<ChangeImageTest> {
  final TextEditingController _imageController = TextEditingController();

  String _image = ''; // Make this accessible across files

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    
                    _image), // Replace with your actual image URL
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(10), // Keeps the border radius
              border: Border.all(
                width: 1,
              ),
            ),
          ),

          SizedBox(height: 20), // Spacing

          Container(
            // This is the container that holds the username and password text fields
            width: 350,
            height: 170,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                  12), // Gives the container rounded edges
            ),

            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers the text fields
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller:
                          _imageController, 
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter a image link',
                      ),
                    ),
                  ),
                  // Password

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Sets the state of the username and password to the text that is inside of the text fields
                        _image = _imageController.text;
                        _imageController.clear();
                      });
                    },
                    child: Text('Change image to input'),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20), // Spacing
          Container(
            width: 350,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('image link: $_image'), // Displays the username
              ],
            ),
          )
        ],
      ),
    );
  }
}
