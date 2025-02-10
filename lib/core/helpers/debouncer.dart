import 'dart:async';
import 'package:flutter/material.dart';

class Debouncerr {
  final int milliseconds;
  Timer? _timer;
  Debouncerr({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void reset() {
    _timer = null;
  }
}
