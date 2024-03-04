import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_provider.g.dart';

@riverpod
class BottomNav extends _$BottomNav {
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
