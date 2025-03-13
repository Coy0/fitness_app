import 'package:flutter/material.dart';


/// This is a default page that was created by Austin to see how to make pages function
class FirstPage extends StatelessWidget {
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
                        'assets/cat_wawa.jpg'), 
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(200), 
                  
                )
              ),























            SizedBox(height: 20), 


            Text('You have'),


            SizedBox(height: 20),























                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/cat_wawa.jpg'), 
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(200), 
                      
                    )
                  ),
          ],
      )
    );
  }
}

