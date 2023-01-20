import 'package:flutter_oop_recture/domain/modular_counter.dart';
/// Implement HourCounter as a class that inherits from ModularCounter
/// in the default constructor to make the counter modulo 12
/// Pass 12 to the superclass constructor and set modular = 12
/// set
class HourCounter extends ModularCounter {
  HourCounter() : super(12);

  @override
  void increment() {
    super.counter++;
    reset();
  }

  @override
  void reset() {
    // Because the reset function uses the implementation of the superclass as it is
    // just call super.reset() internally
    super.reset();
  }
}
