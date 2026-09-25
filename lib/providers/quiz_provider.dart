import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/question.dart';
import '../services/opentdb_service.dart';

enum LoadStatus { idle, loading, success, error }

class QuizProvider extends ChangeNotifier {
  final OpenTdbService _service = OpenTdbService();

  // ---- Categories ----
  List<QuizCategory> categories = [];
  LoadStatus categoryStatus = LoadStatus.idle;
  String? categoryError;

  int? selectedCategoryId;
  String? selectedCategoryName;

  // ---- Configuration ----
  int amount = 10;
  String? difficulty; // null = Any
  String? type; // null = Any

  // ---- Questions / quiz session ----
  List<QuizQuestion> questions = [];
  LoadStatus questionStatus = LoadStatus.idle;
  String? questionError;

  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool answered = false;
  bool quizComplete = false;

  static const int secondsPerQuestion = 20;
  int timeLeft = secondsPerQuestion;
  Timer? _timer;

  DateTime? _quizStartTime;
  Duration totalTime = Duration.zero;

  QuizQuestion? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length
          ? questions[currentIndex]
          : null;


  Future<void> loadSavedConfig() async {
    final prefs = await SharedPreferences.getInstance();
    amount = prefs.getInt('quizzical_amount') ?? 10;
    difficulty = prefs.getString('quizzical_difficulty');
    type = prefs.getString('quizzical_type');
    notifyListeners();
  }

  Future<void> _saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('quizzical_amount', amount);
    if (difficulty != null) {
      await prefs.setString('quizzical_difficulty', difficulty!);
    } else {
      await prefs.remove('quizzical_difficulty');
    }
    if (type != null) {
      await prefs.setString('quizzical_type', type!);
    } else {
      await prefs.remove('quizzical_type');
    }
  }

  Future<void> fetchCategoriesIfNeeded() async {
    if (categoryStatus == LoadStatus.success && categories.isNotEmpty) {
      return; // cached for the session
    }
    categoryStatus = LoadStatus.loading;
    categoryError = null;
    notifyListeners();

    try {
      categories = await _service.fetchCategories();
      categoryStatus = LoadStatus.success;
    } catch (e) {
      categoryError = e.toString().replaceFirst('Exception: ', '');
      categoryStatus = LoadStatus.error;
    }
    notifyListeners();
  }

  void selectCategory(int id, String name) {
    selectedCategoryId = id;
    selectedCategoryName = name;
    notifyListeners();
  }

  void setAmount(int value) {
    amount = value;
    notifyListeners();
  }

  void setDifficulty(String? value) {
    difficulty = value;
    notifyListeners();
  }

  void setType(String? value) {
    type = value;
    notifyListeners();
  }

 
  Future<void> startQuiz() async {
    if (selectedCategoryId == null) return;

    await _saveConfig();

    questionStatus = LoadStatus.loading;
    questionError = null;
    currentIndex = 0;
    score = 0;
    selectedAnswer = null;
    answered = false;
    quizComplete = false;
    notifyListeners();

    try {
      questions = await _service.fetchQuestions(
        amount: amount,
        categoryId: selectedCategoryId!,
        difficulty: difficulty,
        type: type,
      );
      questionStatus = LoadStatus.success;
      _quizStartTime = DateTime.now();
      _startTimer();
    } catch (e) {
      questionError = e.toString().replaceFirst('Exception: ', '');
      questionStatus = LoadStatus.error;
    }
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    timeLeft = secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft <= 1) {
        t.cancel();
        _handleTimeout();
      } else {
        timeLeft -= 1;
        notifyListeners();
      }
    });
  }

  void _handleTimeout() {
    if (answered) return;
    answered = true;
    selectedAnswer = null; // unanswered
    notifyListeners();
  }

  void selectAnswer(String answer) {
    if (answered) return;
    _timer?.cancel();
    answered = true;
    selectedAnswer = answer;
    if (answer == currentQuestion?.correctAnswer) {
      score += 1;
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      currentIndex += 1;
      answered = false;
      selectedAnswer = null;
      _startTimer();
    } else {
      _timer?.cancel();
      quizComplete = true;
      if (_quizStartTime != null) {
        totalTime = DateTime.now().difference(_quizStartTime!);
      }
    }
    notifyListeners();
  }

  void resetForReplay() {
    _timer?.cancel();
    questions = [];
    questionStatus = LoadStatus.idle;
    questionError = null;
    currentIndex = 0;
    score = 0;
    selectedAnswer = null;
    answered = false;
    quizComplete = false;
    timeLeft = secondsPerQuestion;
    notifyListeners();
  }

  void cancelTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}