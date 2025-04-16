import 'package:flutter/widgets.dart';

class CounterService {
  int counterValue = 0;

  void counterIncrease() {
    counterValue++;
    debugPrint('Counter - $counterValue');
  }
}
