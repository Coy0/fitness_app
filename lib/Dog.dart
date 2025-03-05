// ignore_for_file: file_names

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({required this.id, required this.name, required this.age});

  // Convert a Account into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  // Implement toString to make it easier to see information about
  // each account when using the print statement.
  @override
  String toString() {
    return 'Account{id: $id, name: $name, age: $age}';
  }
}