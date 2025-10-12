import 'package:flutter/material.dart';

final Map<String, Map<String, dynamic>> activityMap = {
  "Reading": {
    "icon": Icons.menu_book,
    "color": Colors.amber,
  },
  "Meditation": {
    "icon": Icons.self_improvement,
    "color": Colors.green,
  },
  "Exercise": {
    "icon": Icons.fitness_center,
    "color": Colors.blue,
  },
  "Puzzles": {
    "icon": Icons.extension, // puzzle-like
    "color": Colors.red,
  },
  "Listening to Music": {
    "icon": Icons.music_note,
    "color": Colors.purple,
  },
  "Cooking": {
    "icon": Icons.restaurant_menu,
    "color": Colors.teal,
  },
};

/// Difficulty -> Badge color mapping
final Map<String, Color> difficultyColors = {
  "Easy": Colors.green,
  "Medium": Colors.red,
  "Hard": Colors.orange,
};
