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

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // 1. Dynamic Network Image based on Good / Bad Result
              Image.network(
                isGood
                    ? 'https://media.istockphoto.com/id/2228047366/vector/congratulations-text-for-anniversary-birthday-party-christmas-new-year-graduate-cards.jpg?s=612x612&w=0&k=20&c=yjAchTmDhQjNGmUK4Fm992R3g0XcyQm45Ed7h5Lf_HQ=' // Good result illustration URL
                    : 'https://static.vecteezy.com/system/resources/previews/023/891/661/non_2x/try-again-button-speech-bubble-banner-label-try-again-vector.jpg', // Bad result illustration URL
                height: screenHeight * 0.25,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    isGood ? Icons.celebration : Icons.emoji_events_outlined,
                    size: 100,
                    color: isGood
                        ? const Color(0xFF62D28E)
                        : const Color(0xFFFF4D2D),
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.03),

              // 2. Result Header Title
              Text(
                isGood ? 'Congratulation' : 'Keep Trying!',
                style: TextStyle(
                  fontSize: screenHeight * 0.038,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // 3. Score Badge (Matching UI design with light shadow border)
              Container(
                
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                decoration: BoxDecoration(
                  color: isGood
                      ? const Color(0xFF82EBAD) // Light Green
                      : const Color(0xFFFF4D2D), // Vibrant Orange Red
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isGood
                        ? const Color(0xFFA2F3C3)
                        : const Color(0xFFFF8570),
                    width: 2,
                  ),
                ),
                child: Text(
                  '$accuracy%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.024,
                    fontWeight: FontWeight.bold,
                    color: isGood ? const Color(0xFF1E5E3A) : Colors.white,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.025),

              // 4. Subtitle Text
              Text(
                isGood
                    ? "You've got a great foundation. Ready to try a different category?"
                    : "Dont give up! Practice makes perfect. Try again to improve your score",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenHeight * 0.018,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary.withOpacity(0.85),
                  height: 1.4,
                ),
              ),

              // Hidden Score & Time data for context reference (Optional / Retained)
              const SizedBox(height: 8),
              Text(
                'Score: $score/$total | Time: ${minutes}m ${seconds}s',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 115, 115, 126).withOpacity(0.6),
                ),
              ),

              const Spacer(),

              // 5. PLAY AGAIN Button (Rounded rectangle dark teal style)
              SizedBox(
                width: double.infinity,
                height: 56.0,
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
                    backgroundColor: const Color(0xFF006D63),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'PLAY AGAIN',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
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