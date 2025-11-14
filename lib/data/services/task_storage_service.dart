import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskStorageService {
  static const String _tasksKey = 'tasks_data';

  // Save tasks to SharedPreferences
  static Future<void> saveTasks(List<Map<String, dynamic>> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Convert tasks to JSON string
    final List<Map<String, dynamic>> serializableTasks = tasks.map((task) {
      return {
        'title': task['title'],
        'iconCode': (task['icon'] as IconData).codePoint,
        'colorValue': (task['color'] as Color).value,
        'done': task['done'],
      };
    }).toList();
    
    final String tasksJson = serializableTasks.toString();
    await prefs.setString(_tasksKey, tasksJson);
  }

  // Load tasks from SharedPreferences
  static Future<List<Map<String, dynamic>>?> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(_tasksKey);
    
    if (tasksJson == null) return null;
    
    try {
      // Parse the JSON string back to list
      final List<dynamic> tasksList = tasksJson.split('}, {').map((item) {
        String formattedItem = item
            .replaceAll('[{', '{')
            .replaceAll('}]', '}')
            .replaceAll('{', '{"')
            .replaceAll(':', '":"')
            .replaceAll(', ', '", "')
            .replaceAll('"', '\"');
        
        final parts = formattedItem.split(', ');
        Map<String, dynamic> task = {};
        
        for (String part in parts) {
          final keyValue = part.split(': ');
          if (keyValue.length == 2) {
            String key = keyValue[0].trim().replaceAll('"', '');
            String value = keyValue[1].trim().replaceAll('"', '');
            
            if (key == 'title') {
              task[key] = value;
            } else if (key == 'iconCode') {
              task[key] = int.tryParse(value) ?? Icons.favorite.codePoint;
            } else if (key == 'colorValue') {
              task[key] = int.tryParse(value) ?? Colors.pink.value;
            } else if (key == 'done') {
              task[key] = value.toLowerCase() == 'true';
            }
          }
        }
        
        return task;
      }).toList();

      // Convert back to the original format
      return tasksList.map((task) {
        return {
          "title": task['title'] ?? '',
          "icon": IconData(task['iconCode'] ?? Icons.favorite.codePoint, fontFamily: 'MaterialIcons'),
          "color": Color(task['colorValue'] ?? Colors.pink.value),
          "done": task['done'] ?? false,
        };
      }).toList();
    } catch (e) {
      print('Error loading tasks: $e');
      return null;
    }
  }
}