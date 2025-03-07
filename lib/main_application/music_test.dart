import 'package:flutter/material.dart';


/// This is a music player page created by Coy to see how to make a music player function
/// 
/// Unfinished
class TestMusic extends StatelessWidget {
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
                    'Music Player',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Song 1'),
          ),
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
