import 'package:first_mobile_app_test1/database_tests/Database.dart';

Future<void> addNewAccount(String emailInput, String usernameInput, String passwordInput) async {
  await insertAccount(emailInput, usernameInput, passwordInput);
}

Future<void> deleteAccount(int id) async {
    await database.delete('accounts', where: 'id = ?', whereArgs: [id]);
}