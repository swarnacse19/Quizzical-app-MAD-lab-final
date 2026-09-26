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
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen Title
              Text(
                'Quizzical',
                style: TextStyle(
                  fontSize: screenHeight * 0.038, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Text(
                'choose a category to focus on:',
                style: TextStyle(
                  color: AppColors.textSecondary.withOpacity(0.7),
                  fontSize: screenHeight * 0.015,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: screenHeight * 0.025),

              // Categories Grid View
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
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.88, // Matches screenshot aspect ratio
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
                              imageUrl: style.imageUrl,
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