import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import 'quiz_screen.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().loadSavedConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [           

            // Main Content Scroll Area
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.04), 

                  Image.network(
                    'https://static.vecteezy.com/system/resources/previews/018/765/759/non_2x/quiz-guess-social-media-icon-in-flat-style-faq-illustration-on-isolated-background-help-button-sign-business-concept-vector.jpg',
                    height: screenHeight * 0.22,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.tune,
                        size: 80,
                        color: AppColors.primaryDark,
                      );
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  Text(
                    'Quizzical',
                    style: TextStyle(
                      fontSize: screenHeight * 0.044,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Configuration',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    provider.selectedCategoryName ?? '',
                    style: TextStyle(
                      fontSize: screenHeight * 0.017,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 114, 114, 123).withOpacity(0.9),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Number of Questions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Text(
                        'Select 1–50',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${provider.amount}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF00A3FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: const Color(0xFF00A3FF),
                      inactiveTrackColor: const Color(0xFF00A3FF).withOpacity(0.15),
                      thumbColor: const Color(0xFF00A3FF),
                      overlayColor: const Color(0xFF00A3FF).withOpacity(0.2),
                      trackHeight: 6.0,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    ),
                    child: Slider(
                      min: 1,
                      max: 50,
                      divisions: 49,
                      value: provider.amount.toDouble(),
                      label: '${provider.amount}',
                      onChanged: (v) => provider.setAmount(v.round()),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Difficulty Level',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _Dropdown<String?>(
                    value: provider.difficulty,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Any Difficulty')),
                      DropdownMenuItem(value: 'easy', child: Text('Easy')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'hard', child: Text('Hard')),
                    ],
                    onChanged: provider.setDifficulty,
                  ),

                  const SizedBox(height: 16),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Question Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _Dropdown<String?>(
                    value: provider.type,
                    items: const [
                      DropdownMenuItem(value: null, child: Text('Any Type')),
                      DropdownMenuItem(
                          value: 'multiple', child: Text('Multiple Choice')),
                      DropdownMenuItem(
                          value: 'boolean', child: Text('True / False')),
                    ],
                    onChanged: provider.setType,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // START Quiz Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.0,
                    child: OutlinedButton(
                      onPressed: () async {
                        await provider.startQuiz();
                        if (context.mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const QuizScreen()),
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF006D63),
                        side: const BorderSide(color: Color(0xFF006D63), width: 1.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'START',
                        style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Bottom Outlined Modern Back Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.0,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: BorderSide(color: Colors.grey.shade300, width: 1.2),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      label: const Text(
                        'Back to Categories',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T> onChanged;

  const _Dropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textPrimary,
            fontFamily: 'Roboto',
          ),
          items: items,
          onChanged: (v) => onChanged(v as T),
        ),
      ),
    );
  }
}