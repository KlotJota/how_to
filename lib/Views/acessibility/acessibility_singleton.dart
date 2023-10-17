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
