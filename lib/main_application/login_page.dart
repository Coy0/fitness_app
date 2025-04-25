import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:flutter/material.dart';


class TestLogin extends StatefulWidget {
  @override
  State<TestLogin> createState() => _TestLoginState();
}

/// This creates a controler for the email and password text fields
/// to allow for the text to be stored and displayed on the screen
class _TestLoginState extends State<TestLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String successfulLogin = ''; // This is the string that will be displayed when the user logs in

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
                    image: AssetImage('assets/cat_wawa.jpg'), // Main Logo
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                      BorderRadius.circular(200), // Makes the image a circle
                  border: Border.all(
                    width: 1000,
                  ))),

          SizedBox(height: 20), // Spacing


          Text(
            'Sign in to [App_Name]',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),

          SizedBox(height: 20), // Spacing

          Container(
            // This is the container that holds the email and password text fields
            width: 350,
            height: 230,
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
                      String email = _emailController.text; // Gets the email from the text field
                      String password = _passwordController.text; // Gets the password from the text field

                      // Call the function to get the account from the database
                      await getAccount(email, password); // This is where you would call the function to check if the email and password are correct

                      if (accounts.isNotEmpty) {
                        setState(() {
                          successfulLogin =
                              "Login Successful!"; 
                        });
                        print(
                            "Login successful!"); 
                      } else {
                        setState(() {
                          successfulLogin =
                              "Login Unsuccessful."; 
                        });
                        print(
                            "Login failed!"); 
                      }
                    },
                    child: Text('Sign in'),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20), // Spacing

          Container(
            // This is the container that holds the email and password text fields
            width: 350,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                  12), // Gives the container rounded edges
            ),

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(successfulLogin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose(); // Disposes of the email controller
    _passwordController.dispose(); // Disposes of the password controller
    super.dispose();
  }
}