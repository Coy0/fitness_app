import 'package:english_words/english_words.dart';
import 'package:first_mobile_app_test1/main_application/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:first_mobile_app_test1/main_application/login.dart';
import 'package:first_mobile_app_test1/main_application/music_test.dart';
import 'package:first_mobile_app_test1/main_application/video_player_test.dart';

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
        page = HomePage();

      case 2:
        page = FavoritesPage();

      case 3:
        page = TestMusic();

      case 4:
        page = VideoPlayerTest();

      case 5: 
        page = FirstPage();

      default:
        throw UnimplementedError('no widget for $selectedIndex');
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
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.music_note),
                      label: Text('Music'),
                    ),

                    NavigationRailDestination(
                      icon: Icon(Icons.play_arrow),
                      label: Text('Video'),
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

/// This is the method that defines the "Home" page
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>(); // This defines the current state of the application
    var pair = appState.current; // This is the word pair that is currently being displayed

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else if (appState.favorites.contains(pair)) {
      icon = Icons.login_outlined;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10), // Spacing
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon( // This is the button that allows you to favorite a given word pair
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10), // Spacing
              ElevatedButton( // This is the button that allows you to get the next word pair
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// This is the method that defines the card that displays the word pairs inside of the "Home" page
class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20), // Defines the size of the box in which the text is located in
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}", 
        ),
      ),
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
