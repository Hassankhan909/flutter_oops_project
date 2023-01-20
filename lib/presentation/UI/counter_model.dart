import 'package:flutter/material.dart';
import 'package:flutter_oop_recture/domain/counter_base.dart';
import 'package:flutter_oop_recture/domain/counter_type.dart';
import 'package:flutter_oop_recture/domain/hour_counter.dart';
import 'package:flutter_oop_recture/domain/simple_counter.dart';
import 'package:flutter_oop_recture/domain/storage_repository_base.dart';

class CounterModel extends ChangeNotifier {
  CounterModel({@required StorageRepositoryBase storageRepository})
      : _storageRepository = storageRepository;

  final StorageRepositoryBase _storageRepository;

  // Originally not very desirable, but _counter is initialized in the initialization process
  // reading the value of count with a safe call from _counter
  int get count => _counter?.counter;
  bool isChangedHourCounter = true;
  CounterBase _counter;
  CounterType _counterType;

  /// Initialize this model
  /// Determine if there is a counter type stored in shared_preferences
  /// If so, assign that Counter, else assign HourCounter
  Future<void> init() async {
    final bool isExistKey = await _storageRepository.isExistKey(key_counter);
    if (isExistKey) {
      final String loadKey =
          await _storageRepository.loadPersistenceStorage(key_counter);
      _counterType = Counter.from(loadKey);
    } else {
      _counterType = CounterType.hourCounter;
    }
    switch (_counterType) {
      case CounterType.hourCounter:
        isChangedHourCounter = true;
        _counter = HourCounter();
        break;
      case CounterType.simpleCounter:
        isChangedHourCounter = false;
        _counter = SimpleCounter();
        break;
      default:
        isChangedHourCounter = true;
        _counter = HourCounter();
    }
    notifyListeners();
  }

  /// Call Counter's increment method
  /// Since increment is defined in the superclass of counter
  /// Both SimpleCounter and HourCounter can call increment
  void increment() {
    _counter.increment();
    notifyListeners();
  }

  /// Switch Counter depending on whether Switch is true or false
  /// save to shared_preferences at the same time
  Future<void> switchCounter() async {
    if (isChangedHourCounter) {
      _counter = SimpleCounter();
      isChangedHourCounter = false;
      await _storageRepository.savePersistenceStorage(
          key_counter, CounterType.simpleCounter.value);
    } else {
      _counter = HourCounter();
      isChangedHourCounter = true;
      await _storageRepository.savePersistenceStorage(
          key_counter, CounterType.hourCounter.value);
    }
    notifyListeners();
  }
}
