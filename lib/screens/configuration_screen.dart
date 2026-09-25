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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.tune, size: 72, color: AppColors.primaryDark),
              const SizedBox(height: 16),
              const Text(
                'Quizzical',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const Text('Configuration',
                  style: TextStyle(color: AppColors.textSecondary)),
              Text(
                provider.selectedCategoryName ?? '',
                style: const TextStyle(
                    color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Number of Questions',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ),
              Row(
                children: [
                  const Text('Select 1-50',
                      style: TextStyle(color: AppColors.textSecondary)),
                  const Spacer(),
                  Text('${provider.amount}',
                      style: const TextStyle(
                          color: AppColors.progressBar,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Slider(
                min: 1,
                max: 50,
                divisions: 49,
                value: provider.amount.toDouble(),
                activeColor: AppColors.progressBar,
                label: '${provider.amount}',
                onChanged: (v) => provider.setAmount(v.round()),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Difficulty Level',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ),
              const SizedBox(height: 6),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Question Type',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
              ),
              const SizedBox(height: 6),
              _Dropdown<String?>(
                value: provider.type,
                items: const [
                  DropdownMenuItem(value: null, child: Text('Any Type')),
                  DropdownMenuItem(
                      value: 'multiple', child: Text('Multiple Choice')),
                  DropdownMenuItem(value: 'boolean', child: Text('True / False')),
                ],
                onChanged: provider.setType,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
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
                    foregroundColor: AppColors.primaryDark,
                    side: const BorderSide(color: AppColors.primaryDark, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('START',
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          items: items,
          onChanged: (v) => onChanged(v as T),
        ),
      ),
    );
  }
}