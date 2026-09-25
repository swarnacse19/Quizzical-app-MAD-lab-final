import 'package:flutter/material.dart';
import 'app_colors.dart';


class CategoryStyle {
  final IconData icon;
  final Color color;

  const CategoryStyle(this.icon, this.color);

  static CategoryStyle forName(String name, int fallbackIndex) {
    final n = name.toLowerCase();

    if (n.contains('general knowledge')) {
      return const CategoryStyle(Icons.public, Color.fromARGB(255, 252, 222, 183));
    }
    if (n.contains('book')) {
      return const CategoryStyle(Icons.menu_book, Color.fromARGB(255, 177, 236, 192));
    }
    if (n.contains('film') || n.contains('movie')) {
      return const CategoryStyle(Icons.movie, Color.fromARGB(255, 238, 173, 184));
    }
    if (n.contains('music')) {
      return const CategoryStyle(Icons.music_note, Color.fromARGB(206, 161, 247, 238));
    }
    if (n.contains('musicals & theatres')) {
      return const CategoryStyle(Icons.theater_comedy, Color.fromARGB(255, 255, 245, 201));
    }
    if (n.contains('television') || n.contains('tv')) {
      return const CategoryStyle(Icons.tv, Color.fromARGB(255, 161, 245, 180));
    }
    if (n.contains('video game')) {
      return const CategoryStyle(Icons.sports_esports, Color(0xFFDCC2F0));
    }
    if (n.contains('board game')) {
      return const CategoryStyle(Icons.casino, Color(0xFFF7DCB8));
    }
    if (n.contains('science: computers') || n.contains('computer')) {
      return const CategoryStyle(Icons.computer, Color.fromARGB(255, 241, 122, 156));
    }
    if (n.contains('science: gadgets') || n.contains('gadget')) {
      return const CategoryStyle(Icons.devices_other, Color(0xFFF7DCB8));
    }
    if (n.contains('mathematics') || n.contains('math')) {
      return const CategoryStyle(Icons.calculate, Color(0xFFBFE6C9));
    }
    if (n.contains('science') || n.contains('nature')) {
      return const CategoryStyle(Icons.science, Color.fromARGB(223, 142, 205, 240));
    }
    if (n.contains('mythology')) {
      return const CategoryStyle(Icons.auto_stories, Color(0xFFF3E7B0));
    }
    if (n.contains('sports')) {
      return const CategoryStyle(Icons.sports_soccer, Color(0xFFBFE6C9));
    }
    if (n.contains('geography')) {
      return const CategoryStyle(Icons.map, Color(0xFFAFC9F0));
    }
    if (n.contains('history')) {
      return const CategoryStyle(Icons.history_edu, Color(0xFFF3E7B0));
    }
    if (n.contains('politics')) {
      return const CategoryStyle(Icons.gavel, Color(0xFFF6C6CE));
    }
    if (n.contains('art')) {
      return const CategoryStyle(Icons.palette, Color(0xFFF6C6CE));
    }
    if (n.contains('celebrit')) {
      return const CategoryStyle(Icons.star, Color(0xFFDCC2F0));
    }
    if (n.contains('animal')) {
      return const CategoryStyle(Icons.pets, Color(0xFFBFE6C9));
    }
    if (n.contains('vehicle')) {
      return const CategoryStyle(Icons.directions_car, Color(0xFFF7DCB8));
    }
    if (n.contains('comic')) {
      return const CategoryStyle(Icons.menu_book, Color(0xFFDCC2F0));
    }
    if (n.contains('gadget')) {
      return const CategoryStyle(Icons.devices, Color(0xFFF7DCB8));
    }
    if (n.contains('anime') || n.contains('manga')) {
      return const CategoryStyle(Icons.face_retouching_natural, Color(0xFFF6C6CE));
    }
    if (n.contains('cartoon')) {
      return const CategoryStyle(Icons.brush, Color(0xFFF3E7B0));
    }

    // Fallback: cycle through the default palette with a generic icon.
    return CategoryStyle(
      Icons.quiz_outlined,
      AppColors.categoryPalette[fallbackIndex % AppColors.categoryPalette.length],
    );
  }
}