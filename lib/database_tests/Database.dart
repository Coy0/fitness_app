// ignore_for_file: file_names

import 'dart:async';
import 'package:first_mobile_app_test1/database_tests/Account.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

 late Database database;

late List<Account> accounts;


Future<void> databaseTest() async {
  try {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    var databasesPath = await getDatabasesPath();
    print("Database Path: $databasesPath");

    database = await openDatabase(
      '$databasesPath/my_database.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE accounts(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)',
        );

        await db.insert('accounts', {
          'email': 'test@example.com',
          'username': 'testuser',
          'password': 'securepassword123',
        });

        print("Default account created.");
      },
    );

    // ✅ Check if the database is empty, and insert a default account if needed
    List<Map<String, dynamic>> maps = await database.query('accounts');
    if (maps.isEmpty) {
      await database.insert('accounts', {
        'email': 'test@example.com',
        'username': 'testuser',
        'password': 'securepassword123',
      });
      print("Inserted default account as the database was empty.");
    }

    accounts = maps.map((map) => Account.fromMap(map)).toList();
    print("Accounts Loaded: $accounts");
  } catch (e) {
    print("Error initializing database: $e");
  }
}


