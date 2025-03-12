// ignore_for_file: unused_local_variable, file_names

import 'dart:async';

import 'package:first_mobile_app_test1/database_tests/Account.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
Future<void> main() async {
  // Initialize FFI
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  WidgetsFlutterBinding.ensureInitialized();
  
  await databaseTest(); // Ensure database setup completes before proceeding
}


Future<void> databaseTest() async {
    var databasesPath = await getDatabasesPath();
print(getDatabasesPath());
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'account_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE accounts(id INTEGER PRIMARY KEY, email TEXT, username TEXT, password TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts dogs into the database
  Future<void> insertAccount(Account account) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'accounts',
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Account>> accounts() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the dogs.
    final List<Map<String, Object?>> accountMaps = await db.query('accounts');

    // Convert the list of each dog's fields into a list of `Dog` objects.

    return accountMaps.map((map) => Account(
      id: map['id'] as int,
      email: map['email'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    )).toList();
      
      // for (final {'id': id as int, 'email': email as String, 'username': username as String, 'password': password as String} in accountMaps)
      
  }


  Future<void> updateAccount(Account account) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'accounts',
      account.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [account.id],
    );
  }

  Future<void> deleteAccount(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'accounts',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Dog and add it to the dogs table
  var coy = Account(id: 0, email: 'ca0002@students.inghamisd.org', username: 'Coy', password: 'wawapassword');
  var test = Account(id: 1, email: 'TESTEMAIL', username: 'username', password: 'password');

  await insertAccount(coy);
  await insertAccount(test);

  print(await accounts()); // Prints a list tha.

  // Update Accounts's age and save it to the database.
  coy = Account(id: coy.id, email: coy.email, username: coy.username, password: coy.password);
  await updateAccount(coy);
  test = Account(id: test.id, email: test.email, username: test.username, password: test.password);
  await updateAccount(test);

  // Print the updated results.
  print(await accounts()); 

  await deleteAccount(test.id);

  print(await accounts());
}