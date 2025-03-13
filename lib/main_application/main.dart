import 'package:english_words/english_words.dart';
import 'package:first_mobile_app_test1/main_application/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:first_mobile_app_test1/main_application/login.dart';
import 'package:first_mobile_app_test1/main_application/databasepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();

  if (Platform.isWindows) {
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MyApp());
}

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
            seedColor: const Color.fromARGB(255, 255, 255, 255), // Seed Color
            surface: const Color.fromARGB(255, 255, 255, 255), // Background Color
          ),
          primaryColor: const Color.fromARGB(255, 255, 255, 255), // Primary Color
          primaryColorLight: const Color.fromARGB(255, 255, 255, 255), // Primary Light Color
          primaryColorDark: const Color.fromARGB(255, 20, 20, 20), // Primary Dark Color
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = TestLogin();
      case 1:
        page = FirstPage();
      case 2:
        page = DatabasePage();
      default:
        throw UnimplementedError('$selectedIndex is not implemented');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: Container(
                  color: Theme.of(context).colorScheme.surface, // Different color for NavigationRail
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 750,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.login),
                        label: Text('Login'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.zoom_out_map),
                        label: Text('Opening page'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.data_array),
                        label: Text('Database'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.tertiary, // Keep background distinct
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