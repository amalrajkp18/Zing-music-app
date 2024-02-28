import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav.g.dart';

@Riverpod(keepAlive: true)
class BottomNav extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void add(int value) {
    state = value;
  }
}

@riverpod
PageController pageController(PageControllerRef ref) {
  return PageController(initialPage: 0);
}
