import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessibilitySettings {
  factory AccessibilitySettings() => _instance;

  AccessibilitySettings._internal();

  static final AccessibilitySettings _instance =
      AccessibilitySettings._internal();

  bool _isAccessibilityEnabled = true;

  bool get isAccessibilityEnabled => _isAccessibilityEnabled;

  void toggleAccessibility() {
    _isAccessibilityEnabled = !_isAccessibilityEnabled;
  }
}

// class AccessibilityModel extends ChangeNotifier {
//   bool _isAccessibilityEnabled = true;

//   bool get isAccessibilityEnabled => _isAccessibilityEnabled;

//   void toggleAccessibility() {
//     _isAccessibilityEnabled = !_isAccessibilityEnabled;
//     notifyListeners(); // Notifica os ouvintes sobre a alteração
//   }
// }
