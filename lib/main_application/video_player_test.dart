import 'package:flutter/material.dart';

class VideoPlayerTest extends StatelessWidget {
  @override

  
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(height: 20),

          Container(
            width: 230,
            height: 50,
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
                  Text(
                    'Video Player',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                
              },
              child: Text('Play'),
            ),
          ),
        ],
      ),
    );
  }
}
