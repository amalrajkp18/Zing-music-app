import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/pages/about/about_page.dart';
import 'package:music_app/presentation/pages/home/home_page.dart';
import 'package:music_app/presentation/pages/library/library_page.dart';
import 'package:music_app/presentation/pages/search/search_page.dart';
import 'package:music_app/presentation/providers/bottom_nav_provider/bottom_nav.dart';

import 'widget/zing_bottom_nav_bar_wodget.dart';

final List<Widget> pagesList = [
  const HomePage(),
  const SearchPage(),
  const LibraryPage(),
  const AboutPage(),
];

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) => PageView(
          controller: ref.watch(pageControllerProvider),
          onPageChanged: (value) {
            ref.read(bottomNavProvider.notifier).add(value);
          },
          children: pagesList,
        ),
      ),
      bottomNavigationBar: const ZingBottomNavBarWidget(),
    );
  }
}
