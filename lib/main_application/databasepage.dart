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

  // Function to add a new account and refresh the UI
  Future<void> addNewAccount() async {
    await insertAccount('extrauser@example.com', 'extrauser', 'extraPass123');

    setState(() {
      _accountsFuture = fetchAccounts(); // Refresh UI with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stored Accounts")),
      body: Column(
        children: [
          // Logo at the top
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/cat_wawa.jpg'), // Main Logo
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(200), // Makes the image a circle
              border: Border.all(width: 2, color: Colors.black),
            ),
          ),
          SizedBox(height: 10), // Adds spacing

          // "Add Account" button
          ElevatedButton(
            onPressed: addNewAccount,
            child: Text("Add New Account"),
          ),

          // Account list inside an expanded widget
          Expanded(
            child: FutureBuilder<List<Account>>(
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

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(account.username),
                        subtitle: Text(account.email),
                        trailing: Text("ID: ${account.id}"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
