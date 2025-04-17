import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/helper_tests/database_helper.dart';
import 'package:email_validator/email_validator.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

/// This creates a controler for the username and password text fields
/// to allow for the text to be stored and displayed on the screen
class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _username = ''; // This is the variable that stores the username
  String _password = ''; // This is the variable that stores the password

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create a [App_Name] Account',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
          ),

          SizedBox(height: 50), // Spacing

          Container(
            // This is the container that holds the username and password text fields
            width: 350,
            height: 350,
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
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller:
                          _emailController, // Saves the email inside of a controller so that the email can be displayed
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your email',
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller:
                          _usernameController, // Saves the username inside of a controller so that the username can be displayed
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller:
                          _passwordController, // Saves the password inside of a controller so that the password can be displayed
                      obscureText:
                          true, // Makes it so you can't see the password
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                    ),
                  ),
                  // Password

                  ElevatedButton(
                    onPressed: () async {
                      _email = _emailController.text;
                      _username = _usernameController.text;
                      _password = _passwordController.text;
                      if (_email.isEmpty ||
                          _username.isEmpty ||
                          _password.isEmpty) {
                        // Check if any of the fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all fields.'),
                          ),
                        );
                        return;
                      } else if (await checkIfEmailExists(_email)) {
                        // Check if the username already exists in the database
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'An account is already linked with this email.'),
                          ),
                        );
                        return;
                      } else if (_email == _username) {
                        // Check if the email and username are the same
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Email and username cannot be the same.'),
                          ),
                        );
                        return;
                      } else if (_password == _username) {
                        // Check if the password and username are the same
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Password and username cannot be the same.'),
                          ),
                        );
                        return;
                      } else if (_password.length < 6) {
                        // Check if the password is less than 6 characters
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Password must be at least 6 characters.'),
                          ),
                        );
                        return;
                      } else if (_username.length < 3) {
                        // Check if the username is less than 3 characters
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Username must be at least 3 characters.'),
                          ),
                        );
                        return;
                      } else if (!EmailValidator.validate(_email)) {
                        // Check if the email is valid using the email_validator package
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Please enter a valid email address.'),
                          ),
                        );
                        return;
                      }

                      await addNewAccount(_email, _username, _password);
                    },
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
