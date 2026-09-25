class QuizCategory {
  final int id;
  final String name;

  const QuizCategory({required this.id, required this.name});

  factory QuizCategory.fromJson(Map<String, dynamic> json) {
    return QuizCategory(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}