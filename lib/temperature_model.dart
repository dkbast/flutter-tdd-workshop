import 'package:flutter/material.dart';

class TemperatureModel extends ChangeNotifier {
  static const stepWidth = 5;
  static const initialValue = 19.0;
  double _temperature = initialValue;

  double get temperature => _temperature;

  set temperature(double value) {
    _temperature = value;
    notifyListeners();
  }

  /// Increases the [temperature] by 5º
  void increment() {
    _temperature += stepWidth;
    notifyListeners();
  }

  /// Decreases the [temperature] by 5º
  void decrement() {
    _temperature -= stepWidth;
    notifyListeners();
  }
}
