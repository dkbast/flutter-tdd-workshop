import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_simulation/temperature_model.dart';

void main() {
  test('initial value is 19', () {
    final model = TemperatureModel();
    expect(model.temperature, TemperatureModel.initialValue);
  });

  group('increment', () {
    late TemperatureModel model;
    setUp(() {
      model = TemperatureModel();
    });
    test('should increase temperature by 5', () {
      model.increment();
      expect(model.temperature,
          TemperatureModel.initialValue + TemperatureModel.stepWidth);
    });

    //TODO pwelsch: Provider testen -> notifyListeners
  });
  group('decrement', () {
    late TemperatureModel model;
    setUp(() {
      model = TemperatureModel();
    });
    test('should decrement temperature by 5', () {
      model.decrement();
      expect(model.temperature,
          TemperatureModel.initialValue - TemperatureModel.stepWidth);
    });
  });
}
