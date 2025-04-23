import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/helper_tests/database_helper.dart' as helper;
import 'package:first_mobile_app_test1/database_tests/Database.dart' as db;
import 'package:provider/provider.dart';

class StartupPage extends StatefulWidget {
  @override
  State<StartupPage> createState() => _StartupState();
}


class _StartupState extends State<StartupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String successfulLogin = '';
  // ignore: non_constant_identifier_names
  String _SiteImage =
      'https://lh3.googleusercontent.com/2gat55trm1IciUq_O7tQSQDeT_AIwX-lsIS6sZ5S5kjmiPKP8HBg_CPIbJi2R1uCSBiPs-2-s10NLckz=w544-h544-l90-rj';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    _SiteImage), // Replaces with inputted image URL
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(1000), // Keeps the border radius
              border: Border.all(
                width: 0,
              ),
            ),
          ),

          SizedBox(height: 20), // Spacing

          Text(
            "Welcome to [App Name]",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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

                      // Call the function to get the account from the database// This is where you would call the function to check if the email and password are correct

                      if (email.isEmpty || password.isEmpty) {
                        // Check if any of the fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in all fields.'),
                          ),
                        );
                        return;
                      } else {
                        
                        await db.getAccount(email, password);

                        if (db.accounts.any((element) =>
                            element.email == email &&
                            element.password == password)) {
                          setState(() {
                            
                          });
                          
                        } else {
                          setState(() {
                            
                            ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Login Unsuccessful. Please input a valid email and password.'),
                          ),
                        );
                        return;
                          });
                          print("Login failed!");
                        }
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
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers the text fields
                children: [
                  Text(
                    "New to [App Name]?", // Displays the login status
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(width: 10), // Spacing

                  GestureDetector(
                    onTap: () {
                      // Changes the selected index to 2 to go to the create account page
                      var cart = context.read<helper.MyAppState>();
                      cart.selectedIndex =
                          1; // Changes the selected index to 2 to go to the create account page
                    },
                    child: Text(
                      "Create an account", // Displays the login status
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
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
