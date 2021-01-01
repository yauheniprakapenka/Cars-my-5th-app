import 'dart:math';

class RandomNumberGenerator {
  static generate() {
    return Random().nextInt(100) + 1;
  }
}
