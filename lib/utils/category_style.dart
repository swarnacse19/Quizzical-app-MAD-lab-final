import 'package:flutter/material.dart';
import 'app_colors.dart';

class CategoryStyle {
  final IconData icon;
  final Color color;
  final String? imageUrl;

  const CategoryStyle(this.icon, this.color, {this.imageUrl});

  static CategoryStyle forName(String name, int fallbackIndex) {
    final n = name.toLowerCase();

    // 1. General Knowledge
    if (n.contains('general knowledge')) {
      return const CategoryStyle(
        Icons.public,
        Color(0xFFC3D6FF),
        imageUrl: 'https://abhipedia.abhimanu.com/mdbp/webimg/crbrain.png',
      );
    }

    // 2. Books
    if (n.contains('book')) {
      return const CategoryStyle(
        Icons.menu_book,
        Color(0xFFC2F9CB),
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/018/742/266/small/3d-minimal-opened-book-flying-with-another-books-back-to-school-concept-3d-illustration-free-png.png',
      );
    }

    // 3. Film / Movie
    if (n.contains('film') || n.contains('movie')) {
      return const CategoryStyle(
        Icons.movie,
        Color(0xFFFFC0C6),
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/038/355/492/small/film-strip-movie-production-device-and-tools-3d-illustration-png.png',
      );
    }

    // 4. Music
    if (n.contains('music') && !n.contains('musicals')) {
      return const CategoryStyle(
        Icons.music_note,
        Color(0xFFC3D6FF),
        imageUrl: 'https://static.vecteezy.com/system/resources/previews/048/086/199/non_2x/colorful-icon-representing-learn-music-in-3d-format-isolated-on-a-transparent-background-free-png.png',
      );
    }

    // 5. Musicals & Theatres
    if (n.contains('musicals') || n.contains('theatre')) {
      return const CategoryStyle(
        Icons.theater_comedy,
        Color(0xFFFFF7BD),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3163/3163478.png',
      );
    }

    // 6. Television / TV
    if (n.contains('television') || n.contains('tv')) {
      return const CategoryStyle(
        Icons.tv,
        Color(0xFFC2F9CB),
        imageUrl: 'https://static.vecteezy.com/system/resources/previews/016/779/139/non_2x/television-3d-illustration-isolated-on-transparent-background-png.png',
      );
    }

    // 7. Video Games
    if (n.contains('video game')) {
      return const CategoryStyle(
        Icons.sports_esports,
        Color(0xFFF0C5FF),
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/053/217/552/small/3d-game-controller-metaverse-png.png',
      );
    }

    // 8. Board Games
    if (n.contains('board game')) {
      return const CategoryStyle(
        Icons.casino,
        Color(0xFFFFE3B9),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3063/3063822.png',
      );
    }

    // 9. Mathematics / Math (Specific Match Before General Science)
    if (n.contains('math')) {
      return const CategoryStyle(
        Icons.calculate,
        Color(0xFFC2F9CB),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3965/3965108.png',
      );
    }

    // 10. Computers (Specific Match Before General Science)
    if (n.contains('computer')) {
      return const CategoryStyle(
        Icons.computer,
        Color(0xFFFFC0C6),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3062/3062331.png',
      );
    }

    // 11. Gadgets (Specific Match Before General Science)
    if (n.contains('gadget')) {
      return const CategoryStyle(
        Icons.devices,
        Color(0xFFFFE3B9),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/2933/2933245.png',
      );
    }

    // 12. General Science & Nature
    if (n.contains('science') || n.contains('nature')) {
      return const CategoryStyle(
        Icons.science,
        Color(0xFFF0C5FF),
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/067/522/018/small_2x/dropper-with-green-liquid-and-leaf-in-lab-flask-showing-herbal-extraction-green-chemistry-eco-lab-sustainability-plant-science-nature-based-solution-on-a-transparent-background-3d-illustration-png.png',
      );
    }

    // 13. Mythology
    if (n.contains('mythology')) {
      return const CategoryStyle(
        Icons.auto_stories,
        Color(0xFFFFF7BD),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3223/3223015.png',
      );
    }

    // 14. Sports
    if (n.contains('sports')) {
      return const CategoryStyle(
        Icons.sports_soccer,
        Color(0xFFC2F9CB),
        imageUrl: 'https://cdn3d.iconscout.com/3d/premium/thumb/sports-equipment-3d-icon-png-download-5272652.png',
      );
    }

    // 15. Geography
    if (n.contains('geography')) {
      return const CategoryStyle(
        Icons.map,
        Color(0xFFC3D6FF),
        imageUrl: 'https://file.aiquickdraw.com/imgcompressed/img/compressed_af993cc78894e29724d6cc5129780d02.webp',
      );
    }

    // 16. History
    if (n.contains('history')) {
      return const CategoryStyle(
        Icons.history_edu,
        Color(0xFFFFF7BD),
        imageUrl: 'https://static.vecteezy.com/system/resources/previews/038/105/522/non_2x/history-3d-illustration-icon-png.png',
      );
    }

    // 17. Politics
    if (n.contains('politic')) {
      return const CategoryStyle(
        Icons.gavel,
        Color(0xFFFFC0C6),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3209/3209990.png',
      );
    }

    // 18. Art
    if (n.contains('art')) {
      return const CategoryStyle(
        Icons.palette,
        Color(0xFFFFC0C6),
        imageUrl: 'https://i0.wp.com/picjumbo.com/wp-content/uploads/rainbow-3d-transparent-png-isolated-element-free-image.png?w=600&quality=80',
      );
    }

    // 19. Celebrities
    if (n.contains('celebrit')) {
      return const CategoryStyle(
        Icons.star,
        Color(0xFFF0C5FF),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135789.png',
      );
    }

    // 20. Animals
    if (n.contains('animal')) {
      return const CategoryStyle(
        Icons.pets,
        Color(0xFFC2F9CB),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3069/3069172.png',
      );
    }

    // 21. Vehicles
    if (n.contains('vehicle')) {
      return const CategoryStyle(
        Icons.directions_car,
        Color(0xFFFFE3B9),
        imageUrl: 'https://static.vecteezy.com/system/resources/thumbnails/035/576/135/small_2x/ai-generated-3d-rendering-of-a-beautiful-car-on-transparent-background-ai-generated-free-png.png',
      );
    }

    // 22. Comics
    if (n.contains('comic')) {
      return const CategoryStyle(
        Icons.book,
        Color(0xFFF0C5FF),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3145/3145827.png',
      );
    }

    // 23. Anime & Manga
    if (n.contains('anime') || n.contains('manga')) {
      return const CategoryStyle(
        Icons.face,
        Color(0xFFFFC0C6),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3074/3074058.png',
      );
    }

    // 24. Cartoon & Animations
    if (n.contains('cartoon') || n.contains('animation')) {
      return const CategoryStyle(
        Icons.animation,
        Color(0xFFFFF7BD),
        imageUrl: 'https://cdn-icons-png.flaticon.com/512/3074/3074088.png',
      );
    }

    // Default Fallback
    return CategoryStyle(
      Icons.quiz_outlined,
      AppColors.categoryPalette[fallbackIndex % AppColors.categoryPalette.length],
    );
  }
}