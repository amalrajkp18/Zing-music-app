// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pageControllerHash() => r'bda071dbb7b1672e1cc1cc3e2635363d2b942b4e';

/// See also [pageController].
@ProviderFor(pageController)
final pageControllerProvider = AutoDisposeProvider<PageController>.internal(
  pageController,
  name: r'pageControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pageControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PageControllerRef = AutoDisposeProviderRef<PageController>;
String _$bottomNavHash() => r'b56e9044eb5bd03d8e0331697e4ac8179d6b8af5';

/// See also [BottomNav].
@ProviderFor(BottomNav)
final bottomNavProvider = NotifierProvider<BottomNav, int>.internal(
  BottomNav.new,
  name: r'bottomNavProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bottomNavHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BottomNav = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
