// globals.dart
bool? isLoggedIn;
int selectedIndex = 0;
class WorkoutData {
  static final WorkoutData _instance = WorkoutData._internal();

  factory WorkoutData() => _instance;

  WorkoutData._internal();

  final List<Map<String, dynamic>> workouts = [];
}