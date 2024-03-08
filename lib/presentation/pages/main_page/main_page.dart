import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/pages/about/about_page.dart';
import 'package:music_app/presentation/pages/home/home_page.dart';
import 'package:music_app/presentation/pages/library/widget/library_page.dart';
import 'package:music_app/presentation/widgets/music_player_bar.dart';
import 'package:music_app/presentation/pages/music_player/music_player_page.dart';
import 'package:music_app/presentation/pages/search/search_page.dart';
import 'package:music_app/presentation/providers/bottom_nav_provider/bottom_nav_provider.dart';
import 'package:music_app/presentation/providers/songs_provider/current_songs_provider.dart';

import 'widget/zing_bottom_nav_bar_wodget.dart';

final List<Widget> pagesList = [
  const HomePage(),
  const SearchPage(),
  const LibraryPage(),
  const AboutPage(),
];

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: PageView(
        controller: ref.watch(pageControllerProvider),
        onPageChanged: (value) {
          ref.read(bottomNavProvider.notifier).add(value);
        },
        children: pagesList,
      ),
      // bottom song info and controller
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ref.watch(currentSongsProvider) != null &&
              ref.watch(currentSongsProvider)!.isNotEmpty
          ? MusicPlayerBar(
              onTap: () {
                //Navigate music player screen
                Navigator.pushNamed(context, MusicPlayerPage.routeName);
              },
            )
          : const SizedBox.shrink(),
      bottomNavigationBar: const ZingBottomNavBarWidget(),
    );
  }
}
