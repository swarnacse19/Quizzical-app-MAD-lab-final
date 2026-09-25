import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/category_style.dart';
import '../widgets/category_card.dart';
import '../widgets/loading_view.dart';
import '../widgets/error_retry_view.dart';
import 'configuration_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().fetchCategoriesIfNeeded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quizzical',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'choose a category to focus on:',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Consumer<QuizProvider>(
                  builder: (context, provider, _) {
                    switch (provider.categoryStatus) {
                      case LoadStatus.loading:
                      case LoadStatus.idle:
                        return const LoadingView(label: 'Loading categories...');
                      case LoadStatus.error:
                        return ErrorRetryView(
                          message: provider.categoryError ??
                              'Could not load categories.',
                          onRetry: () {
                            provider.categoryStatus = LoadStatus.idle;
                            provider.fetchCategoriesIfNeeded();
                          },
                        );
                      case LoadStatus.success:
                        return GridView.builder(
                          padding: const EdgeInsets.only(bottom: 24),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 1.05,
                          ),
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            final cat = provider.categories[index];
                            final style =
                                CategoryStyle.forName(cat.name, index);
                            return CategoryCard(
                              name: cat.name,
                              color: style.color,
                              icon: style.icon,
                              onTap: () {
                                provider.selectCategory(cat.id, cat.name);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const ConfigurationScreen(),
                                  ),
                                );
                              },
                            );
                          },
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}