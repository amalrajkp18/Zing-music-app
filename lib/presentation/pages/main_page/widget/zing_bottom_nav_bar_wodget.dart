import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/providers/bottom_nav_provider/bottom_nav_provider.dart';

class ZingBottomNavBarWidget extends ConsumerWidget {
  const ZingBottomNavBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // assign current index
    final int selectedIndex = ref.watch(bottomNavProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: context.width(40)),
      width: context.width(432),
      height: context.height(100),
      decoration: BoxDecoration(
        color: AppColors.bottomNav,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            context.width(40),
          ),
          topRight: Radius.circular(
            context.width(40),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.1),
            blurRadius: context.width(10),
            spreadRadius: context.width(1),
          ),
        ],
      ),
      // bottom nav items
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // home
          InkWell(
            onTap: () {
              // index changer
              ref.read(bottomNavProvider.notifier).add(0);
              // page changer to pagecontroller
              ref.read(pageControllerProvider).jumpToPage(0);
            },
            child: Image.asset(
              selectedIndex == 0
                  ? "assets/icons/ic_home_selected.png"
                  : "assets/icons/ic_home.png",
            ),
          ),
          // search
          InkWell(
            onTap: () {
              // index changer
              ref.read(bottomNavProvider.notifier).add(1);
              // page changer to pagecontroller
              ref.read(pageControllerProvider).jumpToPage(1);
            },
            child: Image.asset(
              selectedIndex == 1
                  ? "assets/icons/ic_search_selected.png"
                  : "assets/icons/ic_search.png",
            ),
          ),
          // libary
          InkWell(
            onTap: () {
              // index changer
              ref.read(bottomNavProvider.notifier).add(2);
              // page changer to pagecontroller
              ref.read(pageControllerProvider).jumpToPage(2);
            },
            child: Image.asset(
              selectedIndex == 2
                  ? "assets/icons/ic_libary_selected.png"
                  : "assets/icons/ic_libary.png",
            ),
          ),
          // about
          InkWell(
            onTap: () {
              // index changer
              ref.read(bottomNavProvider.notifier).add(3);
              // page changer to pagecontroller
              ref.read(pageControllerProvider).jumpToPage(3);
            },
            child: Image.asset(
              selectedIndex == 3
                  ? "assets/icons/ic_about_selected.png"
                  : "assets/icons/ic_about.png",
            ),
          )
        ],
      ),
    );
  }
}
