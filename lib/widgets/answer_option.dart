import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrectAnswer;
  final bool answered;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrectAnswer,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.cardWhite;
    Color border = Colors.grey.shade300;
    Widget trailing = const Icon(Icons.radio_button_unchecked,
        color: AppColors.textSecondary);

    if (answered) {
      if (isCorrectAnswer) {
        // Always reveal the correct answer once answered.
        bg = AppColors.correct;
        border = AppColors.correctBorder;
        trailing = const Icon(Icons.check_circle, color: AppColors.correctBorder);
      }
      if (isSelected && !isCorrectAnswer) {
        bg = AppColors.incorrect;
        border = AppColors.incorrectBorder;
        trailing = const Icon(Icons.cancel, color: AppColors.incorrectBorder);
      }
    }

    return Semantics(
      button: true,
      selected: isSelected,
      label: answered
          ? (isCorrectAnswer
              ? '$text, correct answer'
              : (isSelected ? '$text, your incorrect answer' : text))
          : text,
      child: GestureDetector(
        onTap: answered ? null : onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          constraints: const BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}