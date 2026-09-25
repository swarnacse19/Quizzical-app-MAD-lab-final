import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/question.dart';

class OpenTdbService {
  static const _categoriesUrl = 'https://opentdb.com/api_category.php';
  static const _questionsBaseUrl = 'https://opentdb.com/api.php';

  Future<List<QuizCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse(_categoriesUrl));

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories (HTTP ${response.statusCode}).');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = data['trivia_categories'] as List;
    return list
        .map((e) => QuizCategory.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<QuizQuestion>> fetchQuestions({
    required int amount,
    required int categoryId,
    String? difficulty, // null == "Any"
    String? type, // null == "Any"
  }) async {
    final params = <String, String>{
      'amount': amount.toString(),
      'category': categoryId.toString(),
    };
    if (difficulty != null) params['difficulty'] = difficulty;
    if (type != null) params['type'] = type;

    final uri = Uri.parse(_questionsBaseUrl).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load questions (HTTP ${response.statusCode}).');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final responseCode = data['response_code'] as int;

    if (responseCode != 0) {
      throw Exception(_messageForResponseCode(responseCode));
    }

    final results = data['results'] as List;
    return results
        .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  String _messageForResponseCode(int code) {
    switch (code) {
      case 1:
        return 'Not enough questions are available for this configuration. '
            'Try a lower amount or a different difficulty.';
      case 2:
        return 'Invalid quiz parameters. Please adjust your configuration.';
      case 3:
        return 'Session token not found.';
      case 4:
        return 'All available questions for this configuration have been '
            'used. Try different settings.';
      case 5:
        return 'Too many requests — please wait a moment and try again.';
      default:
        return 'Something went wrong while loading questions.';
    }
  }
}