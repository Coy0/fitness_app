// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/database_tests/Account.dart';

class DatabasePage extends StatefulWidget {
  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  late Future<List<Account>> _accountsFuture;

  @override
  void initState() {
    super.initState();
    _accountsFuture = fetchAccounts(); // Fetch accounts when page loads
  }

  Future<List<Account>> fetchAccounts() async {
    List<Map<String, dynamic>> maps = await database.query('accounts');
    return maps.map((map) => Account.fromMap(map)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stored Accounts")),
      body: FutureBuilder<List<Account>>(
        future: _accountsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No accounts found."));
          }

          final accounts = snapshot.data!;

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return ListTile(
                title: Text(account.username),
                subtitle: Text(account.email),
                trailing: Text("ID: ${account.id}"),
              );
            },
          );
        },
      ),
    );
  }
}
