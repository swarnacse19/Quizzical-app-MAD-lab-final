import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/answer_option.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_retry_view.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            switch (provider.questionStatus) {
              case LoadStatus.loading:
              case LoadStatus.idle:
                return const LoadingView(label: 'Loading questions...');
              case LoadStatus.error:
                return ErrorRetryView(
                  message: provider.questionError ?? 'Could not load questions.',
                  onRetry: () => provider.startQuiz(),
                );
              case LoadStatus.success:
                if (provider.quizComplete) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const ResultScreen()),
                    );
                  });
                  return const LoadingView(label: 'Finishing up...');
                }
                return _QuizBody(provider: provider);
            }
          },
        ),
      ),
    );
  }
}

class _QuizBody extends StatelessWidget {
  final QuizProvider provider;
  const _QuizBody({required this.provider});

  @override
  Widget build(BuildContext context) {
    final question = provider.currentQuestion;
    if (question == null) return const SizedBox.shrink();

    final total = provider.questions.length;
    final current = provider.currentIndex + 1;
    final progress = current / total;

    final options = question.type == 'boolean'
        ? ['True', 'False']
        : question.allAnswers;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text('$current/$total',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
              const SizedBox(width: 12),
              Row(
                children: [
                  const Icon(Icons.timer_outlined,
                      size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text('${provider.timeLeft}s',
                      style: const TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  provider.cancelTimer();
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                icon: const Icon(Icons.logout, size: 16, color: AppColors.textPrimary),
                label: const Text('EXIT',
                    style: TextStyle(color: AppColors.textPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey.shade300,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.progressBar),
            ),
          ),
          const SizedBox(height: 20),
          Text('Score: ${provider.score}',
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.cardWhite,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: options.map((opt) {
                return AnswerOption(
                  text: opt,
                  isSelected: provider.selectedAnswer == opt,
                  isCorrectAnswer: opt == question.correctAnswer,
                  answered: provider.answered,
                  onTap: () => provider.selectAnswer(opt),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: provider.answered
                  ? () => provider.nextQuestion()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                disabledBackgroundColor: Colors.grey.shade300,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Next',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}