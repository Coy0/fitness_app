import 'package:flutter/material.dart';

class TestLogin extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TestLoginState createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              // App Logo
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/cat_wawa.jpg'), // Test Img
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(200),
                  border: Border.all(
                    width: 1000,
                  ))),
          // App Logo

          SizedBox(height: 20),

          Text(
            'Sign in to [App_Name]',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),

          SizedBox(height: 20),

          Container(
            width: 350,
            height: 230,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            // Main Outside Box

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your username',
                      ),
                    ),
                  ),
                  // Username

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your password',
                      ),
                    ),
                  ),
                  // Password

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
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

          SizedBox(height: 20),
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
                Text('Username: $_username'),
                Text('Password: $_password'),
              ],
            ),
          )
        ],
      ),
    );
  }
}