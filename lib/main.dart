
import 'package:first_mobile_app_test1/helper_tests/globals.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';

import 'package:first_mobile_app_test1/main_application/database_page.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/main_application/create_account.dart';
import 'package:first_mobile_app_test1/main_application/startup_page.dart';
import 'package:first_mobile_app_test1/helper_tests/database_helper.dart';
import 'package:first_mobile_app_test1/main_application/workout_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();

  if (Platform.isWindows) {
    databaseFactory = databaseFactoryFfi;
  }

  database = await openDatabase(
    join(await getDatabasesPath(), 'my_database.db'),
  );
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
            seedColor:
                const Color.fromARGB(255, 255, 255, 255), // Light blue theme
            surface: const Color.fromARGB(255, 243, 240, 240), // Very light blue for backgrounds
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Widget page;
    int selectedIndex = context.watch<MyAppState>().selectedIndex;

    switch (selectedIndex) {
      case 0:
        page = StartupPage();
      case 1:
        page = CreateAccount();
      case 2:
      if (isLoggedIn == true) {
      page = WorkoutPage();
    } else {
      // Show SnackBar after frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You must be logged in to access Workout!")),
        );
      });
      page = Center(child: Text("Access denied. Please log in."));
    }
      case 3:
        if (isLoggedIn == true && loggedInUserId == 1) {
      page = Database_Page();
    } else {
      // Show SnackBar after frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid Id or not logged in.")),
        );
      });
      page = Center(child: Text("Access denied."));
    }
      default:
        page = Center(
            child: Text(
                "Invalid Arrival - Selected page was page $context.read<MyAppState>().selectedIndex") //This is the page that you arrive at if none of the above pages are selected
            );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .surface, // Light blue NavigationRail
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 750,
                    groupAlignment: -1,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.add),
                        label: Text('Create Account'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.fitness_center_sharp),
                        label: Text('Workout'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.storage),
                        label: Text('Database'),
                      ),
    
                      
                    ],
                    selectedIndex: context
                        .watch<MyAppState>()
                        .selectedIndex, // Watch for changes to selectedIndex
                    onDestinationSelected: (value) {
                      context.read<MyAppState>().selectedIndex =
                          value; // Update the selected index
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .onError, // Light blue main background
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
