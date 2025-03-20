// ignore_for_file: file_names
import 'dart:async';
import 'package:first_mobile_app_test1/database_tests/Account.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart'; // Import path package

late Database database;
late List<Account> accounts = []; // Initialize accounts

Future<void> databaseTest() async {
  try {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    var databasesPath = await getDatabasesPath();
    print("Database Path: $databasesPath");

    String path = join(databasesPath, 'my_database.db'); // Correct path handling

    database = await openDatabase(
      path,
      version: 2, // Ensure correct version
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE accounts(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)',
        );

        // Insert multiple default accounts
        await db.insert('accounts', {
          'email': 'test@example.com',
          'username': 'testuser',
          'password': 'securepassword123',
        });

        print("Inserted default accounts.");
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Insert a new account when upgrading
        await db.insert('accounts', {
          'email': 'upgradeduser@example.com',
          'username': 'upgradeduser',
          'password': 'upgradepassword789',
        });
        print("Inserted new account during upgrade.");
      },
    );

    // Fetch accounts from the database
    List<Map<String, dynamic>> maps = await database.query('accounts');
    accounts = maps.map((map) => Account.fromMap(map)).toList();
    
    print("Accounts Loaded: $accounts");
  } catch (e) {
    print("Error initializing database: $e");
  }
}

// Function to insert a new account dynamically
Future<void> insertAccount(String email, String username, String password) async {

  await database.insert('accounts', {
    'email': email,
    'username': username,
    'password': password,
  });

  print("Inserted new account: $username");

  // Fetch and print updated accounts
  List<Map<String, dynamic>> maps = await database.query('accounts');
  accounts = maps.map((map) => Account.fromMap(map)).toList();
  
  print("Updated Accounts: $accounts");
}
// Function to insert a new account dynamically
Future<void> getAccount( String username, String password) async {

  // Fetch and print updated accounts
  String whereStatement =  'username = "$username" AND password = "$password"';
  print(whereStatement);
  List<Map<String, dynamic>> maps = await database.query('accounts',where:whereStatement);
  accounts = maps.map((map) => Account.fromMap(map)).toList();

  
  print("Updated Accounts: $accounts");
}