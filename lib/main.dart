import 'package:first_mobile_app_test1/main_application/firstpage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'package:first_mobile_app_test1/main_application/login.dart';
import 'package:first_mobile_app_test1/database_tests/database_page.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/main_application/change_image_test.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();

  if (Platform.isWindows) {
    databaseFactory = databaseFactoryFfi;
  }
  
  database= await openDatabase(
  // Set the path to the database. Note: Using the `join` function from the
  // `path` package is best practice to ensure the path is correctly
  // constructed for each platform.
  join(await getDatabasesPath(), 'my_database.db'),
);

 runApp(Database_Page());
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
            seedColor: const Color.fromARGB(255, 0, 0, 0), // Light blue theme
            surface: const Color.fromARGB(255, 255, 255, 255), // Very light blue for backgrounds
          ),
          primaryColor: const Color.fromARGB(255, 105, 111, 117), // Primary Color
          primaryColorLight: const Color.fromARGB(255, 173, 216, 230), // Lighter blue
          primaryColorDark: const Color.fromARGB(255, 20, 20, 20), // Dark Theme Color
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
        page = ChangeImageTest();
      case 3:
        page = Database_Page();
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
                  color: Theme.of(context).colorScheme.surface, // Light blue NavigationRail
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
                        icon: Icon(Icons.image),
                        label: Text('Display input'),
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
                  color: Theme.of(context).colorScheme.surface, // Light blue main background
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
