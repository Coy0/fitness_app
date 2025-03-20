import 'package:first_mobile_app_test1/database_tests/Database.dart';

Future<void> addNewAccount(String emailInput, String usernameInput, String passwordInput) async { // This is the method that will add an account to the database
  await insertAccount(emailInput, usernameInput, passwordInput);
}

Future<void> deleteAccount(int id) async { // This is the method that allows an account to be taken out of the database
    await database.delete('accounts', where: 'id = ?', whereArgs: [id]);
}


Future<void> getAccount(String usernameInput, String passwordInput) async { // This is the method that allows an account to be taken out of the database
    await getAccount( usernameInput,  passwordInput);
}