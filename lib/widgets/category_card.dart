import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final IconData icon;
  final String? imageUrl;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.color,
    required this.icon,
    this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18), // Curved corners like screenshot
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Center Image or Icon
            Expanded(
              child: Center(
                child: imageUrl != null && imageUrl!.startsWith('http')
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          icon,
                          size: 64,
                          color: const Color(0xFF2D3748),
                        ),
                      )
                    : Icon(
                        icon,
                        size: 64,
                        color: const Color(0xFF2D3748),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            // Category Label at the bottom left
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748), // Dark primary color
                letterSpacing: 0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}