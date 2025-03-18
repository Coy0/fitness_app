// ignore_for_file: library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:first_mobile_app_test1/database_tests/Database.dart';
import 'package:first_mobile_app_test1/database_tests/Account.dart';

class Database_Page extends StatefulWidget {
  @override
  _DatabasePageState createState() => _DatabasePageState();
}

class _DatabasePageState extends State<Database_Page> {
  late Future<List<Account>> _accountsFuture;
  final TextEditingController _usernameController = TextEditingController();
  String _username = ''; // This is the variable that stores the username

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
    await insertAccount('TestUser@test.com', 'TestUser', 'TestPass');

    setState(() {
      _accountsFuture = fetchAccounts(); // Refresh UI with new data
    });
  }

  Future<void> deleteAccount(int id) async {
    await database.delete('accounts', where: 'id = ?', whereArgs: [id]);

    setState(() {
      _accountsFuture = fetchAccounts(); // Refresh UI with new data
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stored Accounts")),
      body: Row(
        children: [
          // Logo at the top
          SizedBox(height: 10), // Adds spacing

          // "Add Account" button

          SizedBox(height: 10), // Adds spacing

          Container(
            // This is the container that holds the username and password text fields
            width: 400,
            height: 170,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                  12), // Gives the container rounded edges
            ),

            child: Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centers the text fields
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16), // Size of the text field
                    child: TextField(
                      controller:
                          _usernameController, // Saves the username inside of a controller so that the username can be displayed
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter ID of Account to Delete',
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: addNewAccount,
                        child: Text('Add New Account'),
                      ),

                      SizedBox(width: 10), // Adds spacing

                      ElevatedButton(
                        onPressed: () async {
                          await deleteAccount(int.parse(_usernameController.text));

                          setState(() {
                            _accountsFuture = fetchAccounts(); // Refresh UI with new data
                          });
                        },
                        child: Text("Delete Typed Account"),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

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

          SizedBox(height: 10), // Adds spacing
        ],
      ),
    );
  }
}
