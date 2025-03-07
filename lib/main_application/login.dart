import 'package:flutter/material.dart';

class TestLogin extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TestLoginState createState() => _TestLoginState();
}

/// This creates a controler for the username and password text fields
/// to allow for the text to be stored and displayed on the screen
class _TestLoginState extends State<TestLogin> { 
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  String _username = ''; // This is the variable that stores the username
  String _password = ''; // This is the variable that stores the password

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
                        'assets/cat_wawa.jpg'), // Main Logo
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(200), // Makes the image a circle
                  border: Border.all(
                    width: 1000,
                  )
                )
              ),

          SizedBox(height: 20), // Spacing

          Text(
            'Sign in to [App_Name]',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),

          SizedBox(height: 20), // Spacing

          Container( // This is the container that holds the username and password text fields
            width: 350,
            height: 230,
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller: _usernameController, // Saves the username inside of a controller so that the username can be displayed
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller: _passwordController, // Saves the password inside of a controller so that the password can be displayed
                      obscureText: true, // Makes it so you can't see the password
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                    ),
                  ),
                  // Password

                  ElevatedButton(
                    onPressed: () {
                      setState(() { // Sets the state of the username and password to the text that is inside of the text fields
                        _username = _usernameController.text;
                        _password = _passwordController.text;
                      });
                    },
                    child: Text('Sign in'),
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
                Text('Username: $_username'), // Displays the username
                Text('Password: $_password'), // Displays the password
              ],
            ),
          )
        ],
      ),
    );
  }
}