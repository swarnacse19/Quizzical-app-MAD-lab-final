import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/welcome_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(const QuizzicalApp());
}

class QuizzicalApp extends StatelessWidget {
  const QuizzicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        title: 'Quizzical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primaryDark,
            primary: AppColors.primaryDark,
          ),
          fontFamily: 'Roboto',
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
