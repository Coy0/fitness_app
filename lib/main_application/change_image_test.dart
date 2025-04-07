import 'package:flutter/material.dart';

class ChangeImageTest extends StatefulWidget {
  @override
  State<ChangeImageTest> createState() => _TestLoginState();
}

/// This creates a controler for the text field that allows the user to imput a image uri
class _TestLoginState extends State<ChangeImageTest> {
  final TextEditingController _imageController = TextEditingController();

  String _image =
      'https://lh3.googleusercontent.com/2gat55trm1IciUq_O7tQSQDeT_AIwX-lsIS6sZ5S5kjmiPKP8HBg_CPIbJi2R1uCSBiPs-2-s10NLckz=w544-h544-l90-rj'; // Make this accessible across files

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
                image: NetworkImage(_image), // Replaces with inputted image URL
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
            // This is the container that holds
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
                      controller: _imageController,
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
                        _image = _imageController.text.isEmpty // If there is no input inside of the text box, it sets the image to this default one
                            ? 'https://lh3.googleusercontent.com/2gat55trm1IciUq_O7tQSQDeT_AIwX-lsIS6sZ5S5kjmiPKP8HBg_CPIbJi2R1uCSBiPs-2-s10NLckz=w544-h544-l90-rj'
                            : _imageController.text;
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
