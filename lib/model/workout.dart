class Workout {
  final int id;
  final String name;

  Workout({required this.id, required this.name});

  Map<String, dynamic> toMap() => {'id': id, 'name': name};
}

class Exercise {
  final int id;
  final int workoutId;
  final String name;
  final int reps;
  final double weight;

  Exercise({required this.id, required this.workoutId, required this.name, required this.reps, required this.weight});

  Map<String, dynamic> toMap() => {
        'id': id,
        'workoutId': workoutId,
        'name': name,
        'reps': reps,
        'weight': weight,
      };
}
