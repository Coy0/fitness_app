import 'package:english_words/english_words.dart';
import 'package:first_mobile_app_test1/main_application/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_mobile_app_test1/main_application/login.dart';

/// This is the main method that runs the application on run
void main() {
  runApp(MyApp());
}

/// This defines the base state of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor:
                  const Color.fromARGB(255, 199, 115, 119)), // Seed Color
          primaryColor:
              const Color.fromARGB(255, 199, 115, 119), // Primary Color
          primaryColorLight:
              const Color.fromARGB(255, 199, 115, 119), // Primary Light Color
          primaryColorDark:
              const Color.fromARGB(255, 20, 20, 20), // Primary Dark Color
        ),
        home: MyHomePage(),
      ),
    );
  }
}

/// This is the method that defines the current state of the application
/// as well as adding the word pair to the favorites list, or removing it if unselected
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// This is the method that defines what data is being displayed on the screen
/// as well as sending what page is being displayed to the screen
class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = TestLogin();

      case 1:
        page = FavoritesPage();

      case 2: 
        page = FirstPage();

      default:
        throw UnimplementedError('$selectedIndex is not implemented');
    }

    /// This is the method that creates the bar on the left side of the screen which allows you to navigate between pages
    /// as well as the method that holds the icons and labels for the pages
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 750, // This is the method that defines how far out the bar is allowed to be visable on the screen from the size of the applications window
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.login),
                      label: Text('Login'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.zoom_out_map), 
                      label: Text('Opening page')
                    )
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) { // This is the method that allows you to actually navigate between pages
                    setState(() { // Changes the state of the app to the selected Page
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// This is the method that defines the page that displays the favorited word pairs
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    if (appState.favorites.isEmpty) {
      return Center(child: Text('You have not favorited any words yet.'));
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'You have '
            '${appState.favorites.length} favorite word pairs:',
          ),
        ),
        for (var pair in appState.favorites) // This is the for loop that displays the favorited word pairs
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(pair.asLowerCase),
          ),
      ],
    );
  }
}
