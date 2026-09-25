import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import 'configuration_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final total = provider.questions.length;
    final score = provider.score;
    final accuracy = total == 0 ? 0 : ((score / total) * 100).round();
    final isGood = accuracy >= 60;
    final minutes = provider.totalTime.inMinutes;
    final seconds = provider.totalTime.inSeconds % 60;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isGood ? Icons.celebration : Icons.emoji_events_outlined,
                size: 90,
                color: isGood ? AppColors.resultGoodText : AppColors.resultBad,
              ),
              const SizedBox(height: 16),
              Text(
                isGood ? 'Congratulation' : 'Keep Trying!',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $score/$total!',
                style: const TextStyle(
                    fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                decoration: BoxDecoration(
                  color: isGood ? AppColors.resultGood : AppColors.resultBad,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  '$accuracy%',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isGood
                        ? AppColors.resultGoodText
                        : AppColors.resultBadText,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Total time: ${minutes}m ${seconds}s',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Text(
                isGood
                    ? "You've got a great foundation. Ready to try a different category?"
                    : "Don't give up! Practice makes perfect. Try again to improve your score.",
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    provider.resetForReplay();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (_) => const ConfigurationScreen()),
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('PLAY AGAIN',
                      style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}