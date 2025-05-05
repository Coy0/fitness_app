import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:flutter/material.dart';

Future<void> addNewAccount(String emailInput, String usernameInput, String passwordInput) async { // This is the method that will add an account to the database
  await insertAccount(emailInput, usernameInput, passwordInput);
}

Future<void> deleteAccount(int id) async { // This is the method that allows an account to be taken out of the database
    await database.delete('accounts', where: 'id = ?', whereArgs: [id]);
}


Future<void> getAccount(String usernameInput, String passwordInput) async { // This is the method that allows an account to be taken out of the database
    await getAccount( usernameInput,  passwordInput);
}
var selectedIndex = 0;
  // This is the variable that will be used to change the page that is displayed
class MyAppState extends ChangeNotifier {
  int _selectedIndex = 0;

  // Getter
  int get selectedIndex => _selectedIndex;

  // Setter
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notifies widgets listening to this class
  }
  
}
