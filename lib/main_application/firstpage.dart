import 'dart:math';
import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/main_application/login.dart';
import 'package:first_mobile_app_test1/database_tests/database_page.dart';
import 'package:first_mobile_app_test1/main_application/change_image_test.dart';
import 'package:first_mobile_app_test1/main_application/create_account.dart';


class FirstPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TestLoginState createState() => _TestLoginState();
}

/// This creates a controler for the username and password text fields
/// to allow for the text to be stored and displayed on the screen
class _TestLoginState extends State<FirstPage> { 
  late Widget page;
  Random random = Random();
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

          ElevatedButton(
  onPressed: () {
    int randomPage = random.nextInt(5); // Generates a random number between 0 and 4
    switch (randomPage) {
      case 0:
        page = TestLogin();
      case 1:
        page = CreateAccount();
      case 2:
        page = ChangeImageTest();
      case 3:
        page = Database_Page();
      default:
        throw UnimplementedError('$randomPage is not implemented');
    }

    // Navigate to the selected page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  },
  child: Text('Go to random page in our app'),
),


          
        ],
      ),
    );
  }
}