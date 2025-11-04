import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CustomButton {
  final String id;
  final String name;
  final DateTime createdAt;

  CustomButton({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CustomButton.fromJson(Map<String, dynamic> json) {
    return CustomButton(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class CustomButtonsController extends GetxController {
  final RxList<CustomButton> customButtons = <CustomButton>[].obs;
  final String _storageKey = 'custom_buttons';

  @override
  void onInit() {
    super.onInit();
    _loadCustomButtons();
  }

  /// Load saved buttons from shared preferences
  Future<void> _loadCustomButtons() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? buttonsJson = prefs.getString(_storageKey);

      if (buttonsJson != null) {
        final List<dynamic> buttonsList = json.decode(buttonsJson);
        customButtons.assignAll(
          buttonsList.map((json) => CustomButton.fromJson(json)).toList(),
        );
      }
    } catch (e) {
      print('Error loading custom buttons: $e');
    }
  }

  /// Save buttons to shared preferences
  Future<void> _saveCustomButtons() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String buttonsJson = json.encode(
        customButtons.map((button) => button.toJson()).toList(),
      );
      await prefs.setString(_storageKey, buttonsJson);
    } catch (e) {
      print('Error saving custom buttons: $e');
    }
  }

  /// Add a new custom button
  Future<void> addCustomButton(String name) async {
    final newButton = CustomButton(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      createdAt: DateTime.now(),
    );

    customButtons.add(newButton);
    await _saveCustomButtons();
  }

  /// Remove a custom button by ID
  Future<void> removeCustomButton(String id) async {
    customButtons.removeWhere((button) => button.id == id);
    await _saveCustomButtons();
  }

  /// Check if button exists
  bool buttonExists(String name) {
    return customButtons.any((button) => button.name == name);
  }

  /// Get button by ID
  CustomButton? getButtonById(String id) {
    try {
      return customButtons.firstWhere((button) => button.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear all custom buttons
  Future<void> clearAllButtons() async {
    customButtons.clear();
    await _saveCustomButtons();
  }
}