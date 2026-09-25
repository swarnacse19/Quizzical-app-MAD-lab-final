import 'package:html_unescape/html_unescape.dart';

class QuizQuestion {
  final String category;
  final String type; // 'multiple' or 'boolean'
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  /// Pre-shuffled combined answers, computed once at construction time.
  final List<String> allAnswers;

  QuizQuestion({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  }) : allAnswers = _buildShuffledAnswers(correctAnswer, incorrectAnswers);

  static List<String> _buildShuffledAnswers(
      String correct, List<String> incorrect) {
    final answers = [...incorrect, correct];
    answers.shuffle();
    return answers;
  }

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    final unescape = HtmlUnescape();
    final incorrectRaw = (json['incorrect_answers'] as List)
        .map((e) => unescape.convert(e as String))
        .toList();

    return QuizQuestion(
      category: unescape.convert(json['category'] as String),
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      question: unescape.convert(json['question'] as String),
      correctAnswer: unescape.convert(json['correct_answer'] as String),
      incorrectAnswers: incorrectRaw,
    );
  }
}