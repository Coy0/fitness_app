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
  
  String _image = ''; // This is the variable that stores the username

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        ''), // Main Logo
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10), // Makes the image a circle
                  border: Border.all(
                    width: 1,
                  )
                )
              ),

          SizedBox(height: 20), // Spacing  

          Container( // This is the container that holds the username and password text fields
            width: 350,
            height: 170,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12), // Gives the container rounded edges
            ),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centers the text fields
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller: _imageController, // Saves the password inside of a controller so that the password can be displayed
                      obscureText: true, // Makes it so you can't see the password
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter a image link',
                      ),
                    ),
                  ),
                  // Password

                  ElevatedButton(
                    onPressed: () {
                      setState(() { // Sets the state of the username and password to the text that is inside of the text fields
                        _image = _imageController.text;
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