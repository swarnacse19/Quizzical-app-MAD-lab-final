import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'category_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),

                      Image.network(
                        'https://static.vecteezy.com/system/resources/previews/078/158/958/non_2x/cute-cartoon-brain-character-with-question-marks-and-an-exclamation-point-above-its-head-thinking-hard-vector.jpg', 
                        height: screenHeight * 0.35, 
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          
                          return const Icon(
                            Icons.emoji_objects_outlined,
                            size: 110,
                            color: AppColors.primaryDark,
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.04),

                    
                      Text(
                        'Quizzical',
                        style: TextStyle(
                          fontSize: screenHeight * 0.042, 
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 8),

                      
                      Text(
                        'Saida Khanom Sharna',
                        style: TextStyle(
                          fontSize: screenHeight * 0.026, 
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary.withOpacity(0.8),
                        ),
                      ),

                      const Spacer(),

                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CategoryScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryDark,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), 
                            ),
                          ),
                          child: Text(
                            'GET STARTED',
                            style: TextStyle(
                              fontSize: screenHeight * 0.02, // 
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
          },
        ),
      ),
    );
  }
}