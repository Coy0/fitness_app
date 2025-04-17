import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';

class CustomDataSave extends StatefulWidget {
  @override
  State<CustomDataSave> createState() => _CustomDataSaveState();
}

class _CustomDataSaveState extends State<CustomDataSave> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _customDataController = TextEditingController();
  final TextEditingController _customNameDataController = TextEditingController();

  bool validity = false; // This is the variable that stores the validity of the account
  String validityText = ''; // This is the string that will be displayed when the user logs in
  String customData = '';
  String customNameData = ''; // This is the variable that stores the custom data

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(width: 25), 
          Container(
            width: 350,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      // Call the function to get the account from the database
                      await getAccount(email, password);

                      if (accounts.isNotEmpty) {
                        setState(() {
                          validityText = "Valid Account!";
                          validity = true;
                        });
                      } else {
                        setState(() {
                          validityText = "Invalid Account.";
                          validity = false;
                        });
                      }
                    },
                    child: Text('Sign in'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Validity of submitted account: $validityText'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 50),
          Container(
            width: 350,
            height: 230,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _customNameDataController, // Use controller to get inputted text
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Name of Custom Data',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _customDataController, // Use controller to get inputted text
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Custom Data',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Make sure an account is valid before saving
                      if (validity == true) {
                        // String email = _emailController.text;
                        // String password = _passwordController.text;
                        // String customText = _customDataController.text;
                        // String customNameText = _customNameDataController.text;


                        setState(() {
                          // validityText = "Data saved successfully!";
                        });
                      } else {
                        setState(() {
                          validityText = "Please sign in first!";
                        });
                      }
                    },
                    child: Text('Save inputted text to the specified account'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 25), 
        ],
      ),
    );
  }
}
