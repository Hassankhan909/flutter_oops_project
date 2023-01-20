import 'package:flutter_oop_recture/domain/counter_base.dart';

/// Abstract class for counters with modulus
/// has a field modular initialized in the constructor
/// Create a counter with modular modulus
abstract class ModularCounter extends CounterBase {
  ModularCounter(this.modular);
  final int modular;

  /// Force ModularCounter to implement reset functionality
  /// Implemented using the superclass counter
  void reset() {
    // You can use superclass fields without explicitly writing super.counter    if (counter >= modular) {
    if (counter >= modular) {
      counter = 0;
    }
  }
}
