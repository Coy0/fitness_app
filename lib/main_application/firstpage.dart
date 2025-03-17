import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TestLoginState createState() => _TestLoginState();
}

/// This creates a controler for the username and password text fields
/// to allow for the text to be stored and displayed on the screen
class _TestLoginState extends State<FirstPage> { 
  

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
        ],
      ),
    );
  }
}