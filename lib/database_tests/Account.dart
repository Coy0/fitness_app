// ignore_for_file: file_names

class Account {
  final int id;
  final String email;
  final String username;
  final String password;

  Account({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, Object?> toMap() {
    return {'id': id, 'email': email, 'username': username, 'password': password};
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
    );
  }

  @override
  String toString() {
    return 'Account{id: $id, email: $email, username: $username, password: $password}';
  }
}
