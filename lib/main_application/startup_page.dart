import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/main_application/login_page.dart';


class StartupPage extends StatefulWidget {
  @override
  State<StartupPage> createState() => _StartupState();
}

class _StartupState extends State<StartupPage> {
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
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_SiteImage), // Replaces with inputted image URL
                fit: BoxFit.cover,
              ),
              borderRadius:
                  BorderRadius.circular(1000), // Keeps the border radius
              border: Border.all(
                width: 1000,
              ),
            ),
          ),
          SizedBox(height: 20), // Spacing

          Container(
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
                  ElevatedButton(
                    onPressed: () {
                      // This is the button that will take the user to the login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestLogin(), // Push the LoginPage
                        ),
                      );
                    },
                    child: Text("Go to Login Page"), // Button text
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
