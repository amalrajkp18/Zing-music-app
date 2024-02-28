import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/colors/app_colors.dart';
import 'package:music_app/core/utils/app_responsive_units.dart';
import 'package:music_app/presentation/pages/music_player/music_player_page.dart';
import 'package:music_app/presentation/widgets/music_tile_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            // app title app bar
            SliverAppBar(
              backgroundColor: AppColors.scaffoldBg,
              toolbarHeight: context.height(80),
              title: Text(
                "Zing",
                style: GoogleFonts.pacifico(
                  color: AppColors.white,
                  fontSize: context.width(40),
                ),
              ),
              floating: true,
            ),
            // list view
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => InkWell(
                  onTap: () {
                    // navigate musicplayer
                    Navigator.pushNamed(context, MusicPlayerPage.routeName);
                  },
                  child: const MusicTileWidget(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
